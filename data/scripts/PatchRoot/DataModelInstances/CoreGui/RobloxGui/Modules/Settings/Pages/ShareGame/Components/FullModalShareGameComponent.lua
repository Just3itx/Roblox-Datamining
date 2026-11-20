-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local useStyleSheet = require(CorePackages.Packages.Foundation).Hooks.useStyleSheet

local Modules = CoreGui.RobloxGui.Modules
local scriptParent = script.Parent

local GetFFlagExtraInviteModalStringValidation = require(Modules.Flags.GetFFlagExtraInviteModalStringValidation)
local FFlagFixPromptGameInviteUIButtonScaling = require(Modules.Flags.FFlagFixPromptGameInviteUIButtonScaling)

local ShareGameContainer = require(scriptParent.ShareGameContainer)
local ModalShareGamePageFrame = require(scriptParent.ModalShareGamePageFrame)
local LayoutProvider = require(scriptParent.LayoutProvider)
local InviteSingleUserContainer = require(scriptParent.InviteSingleUserContainer)
local LoadingModal = require(scriptParent.LoadingModal)

local function FoundationStyleLink()
    local styleSheet = useStyleSheet()
    return Roact.createElement("StyleLink", { StyleSheet = styleSheet })
end

local var1 = Roact.PureComponent:extend("FullModalShareGameComponent")

function var1.render(arg1)
    local isVisible = arg1.props.isVisible
    local analytics = arg1.props.analytics
    local onAfterClosePage = arg1.props.onAfterClosePage
    local store = arg1.props.store
    local promptMessage = arg1.props.promptMessage
    local inviteUserId = arg1.props.inviteUserId
    local inviteMessageId = arg1.props.inviteMessageId
    local launchData = arg1.props.launchData
    local isLoading = arg1.props.isLoading
    local requestImpl = arg1.props.requestImpl

    if GetFFlagExtraInviteModalStringValidation() and promptMessage then
        if not inviteUserId then
            promptMessage = promptMessage:gsub("\n", " ")
        end
        if promptMessage:gsub("%s", "") == "" then
            promptMessage = nil
        end
    end

    local createElement = Roact.createElement
    local storeProvider = RoactRodux.StoreProvider
    local tbl1 = { store = store }
    local tbl2 = { screenGui = 0 }
    local createElement2 = Roact.createElement
    local str1 = "ScreenGui"
    local tbl3 = {
        AutoLocalize = false,
        Enabled = isVisible,
        DisplayOrder = -1,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }
    local tbl4 = {
        foundationStyleLink = if FFlagFixPromptGameInviteUIButtonScaling then Roact.createElement(FoundationStyleLink) else nil,
        loadingIndicator = isLoading and Roact.createElement(LoadingModal),
        layoutProvider = 0
    }
    local bool1 = not isLoading

    if bool1 then
        local createElement3 = Roact.createElement
        local var2 = LayoutProvider
        local var3 = nil
        local tbl5 = { ShareGameContainer = 0 }
        local createElement4 = Roact.createElement
        local var4 = ShareGameContainer
        local tbl6 = {
            analytics = analytics,
            isVisible = isVisible,
            skeletonComponent = if inviteUserId then InviteSingleUserContainer else ModalShareGamePageFrame,
            promptMessage = promptMessage,
            inviteUserId = inviteUserId,
            inviteMessageId = inviteMessageId,
            launchData = launchData,
            requestImpl = requestImpl,
            onAfterClosePage = 0
        }

        function tbl6.onAfterClosePage()
            local tbl7 = {}
            for k, _ in pairs(store:getState().Invites) do
                table.insert(tbl7, k)
            end
            onAfterClosePage(tbl7)
        end

        tbl5.ShareGameContainer = createElement4(var4, tbl6)
        bool1 = createElement3(var2, var3, tbl5)
    end

    tbl4.layoutProvider = bool1
    tbl2.screenGui = createElement2(str1, tbl3, tbl4)
    return createElement(storeProvider, tbl1, tbl2)
end

return var1
