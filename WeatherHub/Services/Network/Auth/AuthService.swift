//
//  AuthService.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 24.10.2021.
//

import NodeKit

public class AuthService {

    // MARK: - Constants

    private enum Keys {
    }

    // MARK: - Private Properties

    private var builder: UrlChainsBuilder<AuthUrlRoute> {
        return UrlChainsBuilder()
    }

    // MARK: - Public Methods

    public func register(user: AuthRequestEntity) -> Observer<AuthResponseEntity> {
        return builder
            .route(.post, .register)
            .build()
            .process(user)
    }

    public func signIn(user: AuthRequestEntity) -> Observer<AuthResponseEntity> {
        return builder
            .route(.post, .auth)
            .build()
            .process(user)
    }

    public func resetPassword(for user: PasswordResetRequestEntity) -> Observer<Void> {
        return builder
            .route(.post, .resetPassword)
            .build()
            .process(user)
    }

    public func setNewPassword(_ model: NewPasswordRequestEntity) -> Observer<AuthResponseEntity> {
        return builder
            .route(.post, .newPassword)
            .build()
            .process(model)
    }

}
