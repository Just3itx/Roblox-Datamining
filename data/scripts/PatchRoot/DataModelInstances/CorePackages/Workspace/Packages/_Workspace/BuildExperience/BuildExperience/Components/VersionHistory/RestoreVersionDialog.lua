-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize

local ButtonVariant = Foundation.Enums.ButtonVariant
local FFlagEnableTeamTestLua = SharedFlags.FFlagEnableTeamTestLua

local function RestoreVersionDialog(tbl1)
    local var1 = useLocalization({
        cancel = LocalizationStrings.VERSION_HISTORY_CANCEL,
        revert = LocalizationStrings.CHAT_REVERT_CONFIRMATION_ACTION,
        restore = LocalizationStrings.VERSION_HISTORY_RESTORE
    })
    local cancel = var1.cancel
    local revert = var1.revert
    local restore = var1.restore
    local onActivated = React.useCallback(function()
        if tbl1.isLoading then
            return
        end
        tbl1.onRestore()
    end, { tbl1.isLoading, tbl1.onRestore })
    local var2 = React.useCallback(function()
        if tbl1.isLoading then
            return
        end
        tbl1.onCancel()
    end, { tbl1.isLoading, tbl1.onCancel })

    local var4 = React.useMemo(function()
        local tbl2 = {
            LayoutOrder = 3,
            actions = {
                {
                    text = if FFlagEnableTeamTestLua then revert else restore,
                    variant = ButtonVariant.Emphasis,
                    isDisabled = tbl1.isLoading,
                    isLoading = tbl1.isLoading,
                    onActivated = onActivated
                },
                {
                    text = cancel,
                    variant = ButtonVariant.Standard,
                    isDisabled = tbl1.isLoading,
                    onActivated = var2
                }
            }
        }
        return tbl2
    end, {
        cancel,
        onActivated,
        var2,
        tbl1.isLoading,
        restore,
        revert
    })
    if tbl1.isOpen == false then
        return nil
    end

    return React.createElement(
        Dialog.Root,
        {
            disablePortal = false,
            hasBackdrop = true,
            size = DialogSize.Small,
            testId = "restore-version-dialog"
        },
        {
            Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = tbl1.title }),
            Content = React.createElement(
                Dialog.Content,
                { LayoutOrder = 2 },
                {
                    Description = React.createElement(Dialog.Text, { Text = tbl1.description })
                }
            ),
            Actions = React.createElement(Dialog.Actions, var4)
        }
    )
end
return RestoreVersionDialog
