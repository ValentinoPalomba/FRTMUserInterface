//
//  Route.swift
//  FRTMUserInterface
//
//  Created by PALOMBA VALENTINO on 20/08/25.
//

import Foundation

/// Un protocollo che definisce una rotta navigabile all'interno di un'app.
///
/// Le tue enum di navigazione dovrebbero conformarsi a questo protocollo.
/// Richiede che siano `Hashable` per lavorare con `NavigationPath` di SwiftUI
/// e `Identifiable` per le presentazioni modali (sheet/fullscreenCover) che
/// richiedono un'identità per essere presentate.
public protocol Route: Hashable, Identifiable where Self.ID == Self {
    // Rendiamo Self l'ID per semplicità, ma potresti definire un ID più specifico se necessario
}

// Estensione per fornire un ID predefinito se l'enum si conforma già a Self.ID == Self
extension Route where Self.ID == Self {
    public var id: Self { self }
}
