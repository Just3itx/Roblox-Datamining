-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

local MediaSelector = require(script.Parent.MediaSelector)
local _types = require(script.Parent.types)

local function IconThumbnailsSheet(tbl1)
    local title = useLocalization({ title = LocalizationStrings.MEDIA_SELECTION_TITLE }).title
    local backHandlerRef = React.useRef(nil)

    local onActivated = React.useCallback(function()
        if backHandlerRef.current then
            backHandlerRef.current()
            return
        end
        tbl1.onClose()
    end, { tbl1.onClose })

    return React.createElement(View, { tag = "col size-full bg-surface-0" }, {
        Header = React.createElement(View, {
            LayoutOrder = 1,
            tag = {
                ["composition-content-header row align-y-center gap-small size-full-0 auto-y padding-y-medium"] = true
            }
        }, {
            Back = React.createElement(IconButton, {
                LayoutOrder = 1,
                icon = IconName.ChevronLargeLeft,
                isCircular = true,
                onActivated = onActivated,
                size = InputSize.Large,
                variant = ButtonVariant.Utility
            }),
            Title = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = title,
                tag = "fill auto-y text-heading-medium text-align-x-left text-truncate-end content-emphasis"
            })
        }),
        Content = React.createElement(View, {
            LayoutOrder = 2,
            tag = { ["shrink size-full"] = true }
        }, {
            MediaSelector = React.createElement(
                MediaSelector,
                {
                    universeId = tbl1.universeId,
                    onBack = tbl1.onClose,
                    backHandlerRef = backHandlerRef
                }
            )
        })
    })
end
return IconThumbnailsSheet
