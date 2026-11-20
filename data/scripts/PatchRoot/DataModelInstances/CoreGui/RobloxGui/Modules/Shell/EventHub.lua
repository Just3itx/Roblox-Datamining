-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = ({})

local function createListener(id, callback) -- Luacid: Inlined by compiler; 1 call site recovered
    return { id = id, callback = callback }
end

local module = {}

function module.addEventListener(_, arg1, arg2, callback)
    if tbl1[arg1] == nil then
        tbl1[arg1] = {}
    end

    table.insert(tbl1[arg1], (createListener(arg2, callback)))
end

function module.removeEventListener(_, arg1, id)
    if tbl1[arg1] == nil then
        return
    end

    for i, value in ipairs(tbl1[arg1]) do
        if value ~= nil and value.id == id then
            table.remove(tbl1[arg1], i)
        end
    end
end

function module.removeCallbackFromEvent(_, arg1, id, callback)
    if tbl1[arg1] == nil then
        return
    end

    for i, value in ipairs(tbl1[arg1]) do
        if value ~= nil and value.id == id and value.callback == callback then
            table.remove(tbl1[arg1], i)
            return
        end
    end
end

function module.dispatchEvent(_, arg1, ...)
    if tbl1[arg1] == nil then
        return
    end

    for _, value in ipairs(tbl1[arg1]) do
        value.callback(...)
    end
end

module.Notifications = {
    AuthenticationSuccess = "rbxNotificationAuthenticationSuccess",
    GameJoin = "rbxNotificationGameJoin",
    OpenGames = "rbxNotificationOpenGames",
    OpenGameDetail = "rbxNotificationOpenGameDetail",
    OpenGameGenre = "rbxNotificationOpenGameGenre",
    OpenBadgeScreen = "rbxNotificationOpenBadgeScreen",
    OpenSettingsScreen = "rbxNotificationOpenSettingsScreen",
    OpenSearchScreen = "rbxNotificationOpenSearchScreen",
    OpenStoreScreen = "rbxNotificationOpenStoreScreen",
    OpenAvatarEditorScreen = "rbxNotificationOpenAvatarEditorScreen",
    OpenAccountSettingsScreen = "rbxNotificationOpenAccountSettingsScreen",
    NavigateToEquippedAvatar = "rbxNotificationNavigateToEquippedAvatar",
    NavigateToRobuxScreen = "rbxNotificationNavigateToRobuxScreen",
    RobuxCatalogPurchaseInitiated = "rbxRobuxCatalogPurchaseInitiated",
    DonnedDifferentPackage = "rbxDonnedDifferentPackage",
    VotedOnPlace = "rbxVotedOnPlace",
    AvatarEquipBegin = "rbxAvatarEquipBegin",
    DonnedDifferentOutfit = "rbxDonnedDifferentOutfit",
    AvatarEquipSuccess = "rbxAvatarEquipSuccess",
    AvatarPurchaseBegin = "rbxAvatarPurchaseBegin",
    AvatarPurchaseSuccess = "rbxAvatarPurchaseSuccess",
    FavoriteToggle = "rbxFavoriteToggle",
    PlayedGamesChanged = "rbxPlayedGamesChanged",
    UnlockedUGC = "rbxNotificationUnlockedUGC",
    SetGamesHints = "rbxNotificationSetGamesHints",
    CharacterEquipped = "CharacterEquipped",
    CharacterUpdated = "CharacterUpdated",
    HardwareBundleGranted = "HardwareBundleGranted"
}

return module
