-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local Foundation = require(InExperienceSideSheetParent.Foundation)
local ProfileCard = require(InExperienceSideSheetParent.ProfileCard)
local React = require(InExperienceSideSheetParent.React)
local SharedFlags = require(InExperienceSideSheetParent.SharedFlags)

local View = Foundation.View

local FFlagEnableBlackbirdCheck = SharedFlags.FFlagEnableBlackbirdCheck
local FFlagFlyoutSidePanelUseProfileFrameThumbnail = SharedFlags.FFlagFlyoutSidePanelUseProfileFrameThumbnail

local UnibarList = require(InExperienceSideSheet.Components.UnibarList)

local engineFeature = FFlagEnableBlackbirdCheck and game:GetEngineFeature("ReadHasRobloxSubscriptionLua")

local tbl1 = engineFeature and {
    "Name",
    "DisplayName",
    "MembershipType",
    "HasRobloxSubscription"
}
    or { "Name", "DisplayName", "MembershipType" }

local function createLocalUserModel(player: Player): {displayName: number, id: number, membership: number, name: number}? -- Luacid: Inlined by compiler; 3 call sites recovered
    if not player then
        return nil
    end

    return {
        id = tostring(player.UserId),
        name = player.Name,
        displayName = player.DisplayName,
        membership = player.MembershipType
    }
end

local function isRobloxSubscriber(player: Player) -- Luacid: Inlined by compiler; 3 call sites recovered
    local bool1 = engineFeature
    return bool1 and player ~= nil and player.HasRobloxSubscription == true
end

local function isSameLocalUserModel(arg1, arg2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil or arg2 == nil then
        return arg1 == arg2
    end

    return arg1.id == arg2.id
        and arg1.name == arg2.name
        and arg1.displayName == arg2.displayName
        and arg1.membership == arg2.membership
end

local function useLocalUser()
    local var1, var2 = React.useState(function()
        return createLocalUserModel(Players.LocalPlayer)
    end)
    local var3, var4 = React.useState(function()
        return (isRobloxSubscriber(Players.LocalPlayer))
    end)

    React.useEffect(function()
        local tbl2 = {}

        local function listenToPlayer(player: Player)
            for _, value in tbl2 do
                value:Disconnect()
            end
            table.clear(tbl2)

            var2((createLocalUserModel(player)))
            var4((isRobloxSubscriber(player)))

            if not player then
                return
            end

            for _, value in tbl1 do
                local tbl3 = tbl2
                local rbxScriptSignal = player:GetPropertyChangedSignal(value)

                table.insert(tbl3, rbxScriptSignal:Connect(function()
                    var2(function(arg1)
                        local localUserModel = createLocalUserModel(player)
                        return if if isSameLocalUserModel(arg1, nil) or isSameLocalUserModel(localUserModel, nil) then arg1 == localUserModel else arg1.id == localUserModel.id
                            and arg1.name == localUserModel.name
                            and arg1.displayName == localUserModel.displayName
                            and arg1.membership == localUserModel.membership then arg1 else localUserModel
                    end)
                    var4((isRobloxSubscriber(player)))
                end))
            end
        end

        local connection = Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
            listenToPlayer(Players.LocalPlayer)
        end)
        listenToPlayer(Players.LocalPlayer)

        return function()
            connection:Disconnect()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, {})

    return var1, var3
end

return React.memo(function(tbl2) -- name: UserProfileRow
    local localUserModel, var2 = useLocalUser()

    local createElement = React.createElement
    local var3 = View
    local tbl3 = {
        tag = "row align-y-center gap-small size-full-0 auto-y padding-top-small",
        LayoutOrder = tbl2.layoutOrder,
        testId = "user-profile-row"
    }
    local tbl4 = { ProfileCardContainer = 0, UnibarList = 0 }
    local createElement2 = React.createElement
    local var4 = View
    local tbl5 = { tag = "fill auto-y", LayoutOrder = 0 }

    local tbl6 = { ProfileCard = 0 }
    local createElement3 = React.createElement
    local profileCard = ProfileCard.ProfileCard
    local tbl7 = {
        layoutOrder = 0,
        localUserModel = localUserModel,
        isRobloxSubscriber = 0,
        isCompact = true,
        useProfileFrameThumbnail = 0
    }

    if not FFlagEnableBlackbirdCheck then
        var2 = nil
    end

    tbl7.isRobloxSubscriber = var2

    tbl7.useProfileFrameThumbnail = FFlagFlyoutSidePanelUseProfileFrameThumbnail
    tbl6.ProfileCard = createElement3(profileCard, tbl7)
    tbl4.ProfileCardContainer = createElement2(var4, tbl5, tbl6)

    tbl4.UnibarList = React.createElement(UnibarList, { layoutOrder = 1 })
    return createElement(var3, tbl3, tbl4)
end)
