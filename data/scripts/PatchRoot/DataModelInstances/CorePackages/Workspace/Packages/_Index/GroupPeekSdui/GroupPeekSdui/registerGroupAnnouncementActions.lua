-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:49:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupPeekSdui = script:FindFirstAncestor("GroupPeekSdui")
local GroupPeekSduiParent = GroupPeekSdui.Parent

local GroupPeekSduiConstants = require(GroupPeekSdui.GroupPeekSduiConstants)

local SharedFlags = require(GroupPeekSduiParent.SharedFlags)

local function registerGroupAnnouncementActions()
    if SharedFlags.FFlagSduiCustomFormEnabled then
        require(GroupPeekSduiParent.CustomForms).getSduiCustomFormVerticalRegistry().registerVertical(
            GroupPeekSduiConstants.CUSTOM_FORM_VERTICAL,
            {
                submit = require(GroupPeekSdui.CustomForm.submitGroupCustomFormResponse),
                fetchResults = require(GroupPeekSdui.CustomForm.fetchGroupCustomFormResults)
            }
        )
    end

    if SharedFlags.FFlagSduiReactionsComponent then
        require(GroupPeekSduiParent.SduiSharedContent).getSduiContentReactionVerticalRegistry().registerVertical(
            GroupPeekSduiConstants.CONTENT_REACTION_VERTICAL,
            {
                toggle = require(GroupPeekSdui.Reactions.toggleAnnouncementReaction)
            }
        )
    end
end
return registerGroupAnnouncementActions
