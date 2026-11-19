-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Modules = game:GetService("CoreGui").RobloxGui.Modules

local React = require(CorePackages.Packages.React)
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization

local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)
local isNewInGameMenuEnabled = require(Modules.isNewInGameMenuEnabled)

local Toast = require(CorePackages.Packages.UIBlox).App.Dialog.Toast

local ActionModal = require(script.Parent.ActionModal)

local function BlockingModalContainer(tbl1)
    local player = tbl1.player
    local closeModal = tbl1.closeModal
    local var1 = tbl1.blockingUtility or BlockingUtility
    local analytics = tbl1.analytics
    local source = tbl1.source
    local onBlockingSuccess = tbl1.onBlockingSuccess

    local screenSize, var3 = React.useState(Vector2.new(1000, 1000))
    local show, var5 = React.useState(false)

    local block = React.useCallback(function()
        if not var1:BlockPlayerAsync(player) then
            var5(true)

            return
        end

        analytics:action("SettingsHub", "blockUser", { blockeeUserId = player.UserId, source = source })

        if onBlockingSuccess then
            onBlockingSuccess()
        end
        closeModal()
    end, {
        closeModal,
        player,
        analytics,
        source,
        onBlockingSuccess
    })
    local blockAndReport = React.useCallback(function()
        block()

        local var7 = source or "BlockingModal"

        if isNewInGameMenuEnabled() then
            require(Modules.InGameMenuInit).openReportDialog(player, var7)
            return
        end
        require(Modules.Settings.Pages.ReportAbuseMenuContainerPage):ReportPlayer(player, var7)
    end, { block, player, source })

    local var8 = useLocalization({
        titleKey = {
            "Feature.BlockingModal.Heading.BlockUser",
            DisplayName = player.DisplayName
        },
        bodyKey = "Feature.BlockingModal.Message.BlockConfirmation.FriendsRename",
        cancelTextKey = "Feature.BlockingModal.Action.Cancel",
        blockTextKey = "Feature.BlockingModal.Action.Block",
        blockAndReportTextKey = "Feature.BlockingModal.Action.BlockAndReport",
        blockingFailed = "Feature.Toast.NetworkingError.SomethingIsWrong"
    })

    if show then
        return React.createElement(
            Toast,
            {
                duration = 3,
                show = show,
                toastContent = {
                    toastTitle = var8.blockingFailed,
                    onDismissed = closeModal
                }
            }
        )
    end
    local createElement = React.createElement
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ZIndex = 2
    }

    tbl2[React.Change.AbsoluteSize] = function(arg1)
        var3(arg1.AbsoluteSize)
    end

    return createElement("Frame", tbl2, {
        BlockingModal = React.createElement(ActionModal, {
            screenSize = screenSize,
            title = var8.titleKey,
            body = var8.bodyKey,
            blockText = var8.blockTextKey,
            blockAndReportText = var8.blockAndReportTextKey,
            cancelText = var8.cancelTextKey,
            cancel = closeModal,
            block = block,
            blockAndReport = blockAndReport
        })
    })
end

return BlockingModalContainer
