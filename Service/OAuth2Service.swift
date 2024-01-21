//
//  OAuth2Service.swift
//  ImageFeedFinal
//
//  Created by Максим Казанцев on 30.08.2023.
//

import UIKit

protocol OAuth2ServiceProtocol: AnyObject {
    func fetchAuthToken(_ code: String, completion: @escaping (Result<String,Error>) -> Void)
}

final class OAuth2Service: OAuth2ServiceProtocol {
    fileprivate let DefaultBaseURL = URL(string: "https://api.unsplash.com")!
    
    private enum NetworkError: Error {
        case networkError
        case authorizationCodeError
    }
    
    static let shared = OAuth2Service()
    private let urlSession = URLSession.shared
    
    private ( set ) var authToken: String? {
        get {
            return OAuth2TokenStorage().token
        }
        set {
            guard let getToken = newValue else {return assertionFailure("Error get token")}
            OAuth2TokenStorage().token = getToken
        }
    }
    
    
    func fetchAuthToken(_ code: String, completion: @escaping (Result<String,Error>) -> Void ) {
        let request = authTokenRequest(code: code)
        let task  = object(for: request) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let body):
                let authToken = body.accesToken
                self.authToken = authToken
                completion(.success(authToken))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
}

extension URLRequest {
    static func makeHTTPRequest(
        path: String,
        httpMethod: String,
        baseURL: URL = DefaultBaseURL!
    ) -> URLRequest {
        var request = URLRequest(url: URL(string: path, relativeTo: baseURL)!)
        request.httpMethod = httpMethod
        return request
    }
}

extension OAuth2Service  {
    
    private func object(
        for request: URLRequest,
        completion: @escaping (Result<OAuthTokenResponseBody, Error>) -> Void
    ) -> URLSessionTask {
        let decoder = JSONDecoder()
        return urlSession.data(for: request) { (result: Result <Data, Error>) in
            let response = result.flatMap { data -> Result<OAuthTokenResponseBody, Error> in
                Result { try decoder.decode(OAuthTokenResponseBody.self, from: data) }
            }
            completion(response)
        }
    }
    
    
    private func authTokenRequest(code: String) -> URLRequest {
        URLRequest.makeHTTPRequest(
            path: "/oauth/token"
            + "?client_id=\(AccessKey)"
            + "&&client_secret=\(SecretKey)"
            + "&&redirect_uri=\(RedirectURI)"
            + "&&code=\(code)"
            + "&&grant_type=authorization_code",
            httpMethod: "POST",
            baseURL: URL(string: "https://unsplash.com")!)
    }
    
    private struct OAuthTokenResponseBody: Decodable {
        let accesToken: String
        let tokenType: String
        let scope: String
        let createdAt: Int
        
        enum CodingKeys: String, CodingKey {
            case accesToken = "access_token"
            case tokenType = "token_type"
            case scope
            case createdAt = "created_at"
        }
        
        init(accesToken: String, tokenType: String, scope: String, createdAt: Int) {
            self.accesToken = accesToken
            self.tokenType = tokenType
            self.scope = scope
            self.createdAt = createdAt
        }
        
    }
    
}

extension URLSession {
    
    enum NetworkError: Error {
        case httpStatusCode(Int)
        case urlRequestError(Error)
        case urlSessionError
    }

    
    func data(
        for request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionTask {
        let fulfillCompletion: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
}
        let task = dataTask(with: request, completionHandler: { data, response, error in
            if let data = data,
                let response = response,
                let statusCode = (response as? HTTPURLResponse)?.statusCode
            {
                if 200 ..< 300 ~= statusCode {
                    fulfillCompletion(.success(data))
                } else {
                    fulfillCompletion(.failure(NetworkError.httpStatusCode(statusCode)))
                }
            } else if let error = error {
                fulfillCompletion(.failure(NetworkError.urlRequestError(error)))
            } else {
                fulfillCompletion(.failure(NetworkError.urlSessionError))
            }
        })
        task.resume()
        return task
} }
