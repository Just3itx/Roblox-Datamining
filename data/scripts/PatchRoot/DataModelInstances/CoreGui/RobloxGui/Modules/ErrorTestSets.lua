-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {
    Enum.ConnectionError.PlacelaunchCustomMessage,
    Enum.ConnectionError.PlacelaunchDisabled,
    Enum.ConnectionError.PlacelaunchError,
    Enum.ConnectionError.PlacelaunchFlooded,
    Enum.ConnectionError.PlacelaunchGameEnded,
    Enum.ConnectionError.PlacelaunchGameFull,
    Enum.ConnectionError.PlacelaunchHashException,
    Enum.ConnectionError.PlacelaunchHashExpired,
    Enum.ConnectionError.PlacelaunchHttpError,
    Enum.ConnectionError.PlacelaunchOtherError,
    Enum.ConnectionError.PlacelaunchPartyCannotFit,
    Enum.ConnectionError.PlacelaunchRestricted,
    Enum.ConnectionError.PlacelaunchUnauthorized,
    Enum.ConnectionError.PlacelaunchUserLeft,
    Enum.ConnectionError.PlacelaunchUserPrivacyUnauthorized
}

return {
    [Enum.ConnectionError.ConnectErrors] = {
        Enum.ConnectionError.AlreadyConnected,
        Enum.ConnectionError.NoFreeIncomingConnections,
        Enum.ConnectionError.IPRecentlyConnected,
        Enum.ConnectionError.ConnectionBanned,
        Enum.ConnectionError.InvalidPassword,
        Enum.ConnectionError.OurSystemRequiresSecurity,
        Enum.ConnectionError.IncompatibleProtocolVersion,
        Enum.ConnectionError.DisconnectRaknetErrors
    },
    [Enum.ConnectionError.DisconnectErrors] = {
        Enum.ConnectionError.DisconnectBadhash,
        Enum.ConnectionError.DisconnectBlockedIP,
        Enum.ConnectionError.DisconnectBySecurityPolicy,
        Enum.ConnectionError.DisconnectCloudEditKick,
        Enum.ConnectionError.DisconnectConnectionLost,
        Enum.ConnectionError.DisconnectDevMaintenance,
        Enum.ConnectionError.DisconnectDuplicatePlayer,
        Enum.ConnectionError.DisconnectDuplicateTicket,
        Enum.ConnectionError.DisconnectEvicted,
        Enum.ConnectionError.DisconnectHashTimeout,
        Enum.ConnectionError.DisconnectIdle,
        Enum.ConnectionError.DisconnectIllegalTeleport,
        Enum.ConnectionError.DisconnectNewSecurityKeyMismatch,
        Enum.ConnectionError.DisconnectOnRemoteSysStats,
        Enum.ConnectionError.DisconnectPlayerless,
        Enum.ConnectionError.DisconnectPrivateServerKickout,
        Enum.ConnectionError.DisconnectProtocolMismatch,
        Enum.ConnectionError.DisconnectReceivePacketError,
        Enum.ConnectionError.DisconnectReceivePacketStreamError,
        Enum.ConnectionError.DisconnectRejoin,
        Enum.ConnectionError.DisconnectRobloxMaintenance,
        Enum.ConnectionError.DisconnectSecurityKeyMismatch,
        Enum.ConnectionError.DisconnectSendPacketError,
        Enum.ConnectionError.DisconnectTimeout,
        Enum.ConnectionError.DisconnectWrongVersion,
        Enum.ConnectionError.DisconnectionNotification,
        Enum.ConnectionError.DisconnectTransportIoError,
        Enum.ConnectionError.DisconnectTransportIoInternetError,
        Enum.ConnectionError.DisconnectTransportProtocolError,
        Enum.ConnectionError.DisconnectTransportNgtcp2Error,
        Enum.ConnectionError.DisconnectTransportQuicError,
        Enum.ConnectionError.DisconnectTransportRnaError
    },
    [Enum.ConnectionError.PlacelaunchErrors] = tbl1,
    [Enum.ConnectionError.TeleportErrors] = {
        Enum.ConnectionError.TeleportFailure,
        Enum.ConnectionError.TeleportFlooded,
        Enum.ConnectionError.TeleportGameEnded,
        Enum.ConnectionError.TeleportGameFull,
        Enum.ConnectionError.TeleportGameNotFound,
        Enum.ConnectionError.TeleportIsTeleporting,
        Enum.ConnectionError.TeleportUnauthorized
    }
}
