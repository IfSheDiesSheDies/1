//
//  configure.swift
//  Vapor-telegram-bot-example
//
//  Created by Oleh Hudeichuk on 21.05.2021.
//

import Foundation
import Vapor
import SwiftTelegramSdk

public func configure(_ app: Application) async throws {
        let tgApi: String = "7275567143:AAHQ6fLDZ-_75bn4SikLhaYodMBy9pHajDQ"
    
    /// SET WEBHOOK CONNECTION
    // let bot: TGBot = try await .init(connectionType: .webhook(webHookURL: URL(string: "https://your_domain/telegramWebHook")!),
    //                            dispatcher: nil, tgClient: VaporTGClient(client: app.client),
    //                            tgURI: TGBot.standardTGURL, botId: tgApi, log: app.logger)
    
    /// SET LONGPOLLING CONNECTION
    // set level of debug if you needed
    app.logger.logLevel = .info
    let bot: TGBot = try await .init(connectionType: .longpolling(limit: nil,
                                                                  timeout: nil,
                                                                  allowedUpdates: nil),
                                     dispatcher: nil,
                                     tgClient: VaporTGClient(client: app.client),
                                     tgURI: TGBot.standardTGURL,
                                     botId: tgApi,
                                     log: app.logger)
    await botActor.setBot(bot)
    await DefaultBotHandlers.addHandlers(bot: botActor.bot)
    try await botActor.bot.start()
    
    try routes(app)
}
