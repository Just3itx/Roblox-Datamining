-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local FFlagBuildExperienceLibrary = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceLibrary

local FFlagBuildExperienceInertResourceAttachmentChip = require(BuildExperience.Flags.FFlagBuildExperienceInertResourceAttachmentChip)

local Chip = Foundation.Chip
local View = Foundation.View

local ChipSize = Foundation.Enums.ChipSize
local ChipVariant = Foundation.Enums.ChipVariant

return React.memo(function(tbl1) -- name: ChatResourceAttachmentList
    local bool1 = false
    local tbl2 = ({})
    local testId = tbl1.testId or "ChatResourceAttachmentList"
    local bool2

    if FFlagBuildExperienceInertResourceAttachmentChip then
        bool1 = true
    else
        bool2 = FFlagBuildExperienceLibrary

        if bool2 then
            if tbl1.onRemove == nil then
                bool1 = true
            else
                bool2 = false
            end
        end
    end

    if bool1 then
        bool2 = tbl1.onActivateAttachment == nil
    end
    for layoutOrder, attachment in tbl1.attachments do
        local onRemove = tbl1.onRemove
        local onActivateAttachment = tbl1.onActivateAttachment
        local str1 = `Attachment-{layoutOrder}`
        local createElement = React.createElement
        local var1 = Chip

        local tbl3 = {
            LayoutOrder = layoutOrder,
            onActivated = not bool2 and function()
                if onActivateAttachment ~= nil then
                    onActivateAttachment(layoutOrder)
                elseif onRemove ~= nil then
                    onRemove(layoutOrder)
                end
            end or nil,
            Selectable = not bool2 and nil,
            size = ChipSize.Small,
            text = if attachment.type == "resource_link" then attachment.name else attachment.resource.uri,
            trailing = 0,
            variant = 0,
            testId = 0
        }

        local iconNameX

        if onRemove == nil then
            iconNameX = nil
        elseif bool2 or onActivateAttachment ~= nil then
            iconNameX = {
                iconName = Foundation.Enums.IconName.X,
                onActivated = 0
            }

            function iconNameX.onActivated()
                onRemove(layoutOrder)
            end
        else
            iconNameX = Foundation.Enums.IconName.X
        end

        tbl3.trailing = iconNameX

        tbl3.variant = ChipVariant.Standard
        tbl3.testId = `{testId}.Attachment.{layoutOrder}`
        tbl2[str1] = createElement(var1, tbl3)
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = {
            ["row wrap gap-small size-full-0 auto-y"] = true,
            ["align-x-right"] = tbl1.alignRight == true
        },
        testId = testId
    }, tbl2)
end)
