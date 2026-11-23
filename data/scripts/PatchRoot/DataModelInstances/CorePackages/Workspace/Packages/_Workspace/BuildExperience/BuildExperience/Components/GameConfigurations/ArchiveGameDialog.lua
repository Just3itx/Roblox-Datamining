-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize

local ButtonVariant = Foundation.Enums.ButtonVariant

local function ArchiveGameDialog(tbl1)
    local var1 = useLocalization({
        archiveGame = LocalizationStrings.ARCHIVE_GAME_ARCHIVE,
        cancel = LocalizationStrings.ARCHIVE_GAME_CANCEL,
        description = LocalizationStrings.ARCHIVE_GAME_DESCRIPTION,
        title = LocalizationStrings.ARCHIVE_GAME_TITLE
    })
    local testId = tbl1.testId or "archive-game-dialog"
    local onActivated = React.useCallback(function()
        tbl1.onArchive()
    end, { tbl1.onArchive })
    local var2 = React.useCallback(function()
        tbl1.onCancel()
    end, { tbl1.onCancel })

    local var4 = React.useMemo(function()
        return {
            LayoutOrder = 3,
            actions = {
                {
                    text = var1.archiveGame,
                    variant = ButtonVariant.Standard,
                    onActivated = onActivated
                },
                {
                    text = var1.cancel,
                    variant = ButtonVariant.Standard,
                    onActivated = var2
                }
            }
        }
    end, { onActivated, var2 })

    if tbl1.isOpen == false then
        return nil
    end

    return React.createElement(Dialog.Root, {
        disablePortal = tbl1.disablePortal == true,
        hasBackdrop = tbl1.hasBackdrop == nil or tbl1.hasBackdrop,
        size = DialogSize.Small,
        testId = testId
    }, {
        Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = tbl1.title or var1.title }),
        Content = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                Description = React.createElement(Dialog.Text, { Text = tbl1.description or var1.description })
            }
        ),
        Actions = React.createElement(Dialog.Actions, var4)
    })
end

return ArchiveGameDialog
