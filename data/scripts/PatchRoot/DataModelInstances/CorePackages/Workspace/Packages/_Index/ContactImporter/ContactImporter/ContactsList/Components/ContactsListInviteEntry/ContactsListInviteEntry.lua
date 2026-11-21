-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local dependencies = require(ContactImporter.dependencies)

local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox

local React = dependencies.React

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local TextKeys = require(ContactImporter.Common.TextKeys)
local StandardButtonSize = UIBlox.App.Button.Enum.StandardButtonSize

local SMSProtocol = dependencies.SMSProtocol
local Dash = dependencies.Dash
local useStyle = dependencies.useStyle
local useLocalization = dependencies.useLocalization

local getFFlagContactsListEntryUpdatedTruncationFix = require(ContactImporter.Flags.getFFlagContactsListEntryUpdatedTruncationFix)

local sendInviteLink = require(script.Parent.sendInviteLink)

local tbl1 = {
    smsProtocol = SMSProtocol.default
}

function ContactsListInviteEntry(tbl2)
    local var1 = Dash.join(tbl1, tbl2)

    local var2 = useLocalization({ invite = TextKeys.INVITE_BUTTON_TEXT })

    local var3 = useStyle()
    local var4 = sendInviteLink(
        {
            address = var1.phoneNumber,
            deviceContactId = var1.deviceContactId,
            smsProtocol = SMSProtocol.default
        }
    )

    local xOffset, var5 = React.useState(0)

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl3 = {
        Name = var1.deviceContactId,
        Size = UDim2.new(1, 0, 0, 72),
        BorderSizePixel = 0,
        BackgroundTransparency = 1
    }

    local tbl4 = { entryContent = 0, divider = 0 }
    local createElement2 = Roact.createElement
    local str2 = "Frame"
    local tbl5 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }
    local tbl6 = {
        padding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 26), PaddingBottom = UDim.new(0, 26) }),
        contactNameLabel = 0,
        sendInviteButton = 0
    }
    local element

    if getFFlagContactsListEntryUpdatedTruncationFix() then
        element = Roact.createElement(StyledTextLabel, {
            size = UDim2.new(1, xOffset, 0, 20),
            colorStyle = var3.Theme.TextEmphasis,
            fontStyle = var3.Font.Header2,
            lineHeight = 1,
            text = var1.contactName,
            fluidSizing = false,
            richText = false,
            textWrapped = false,
            textXAlignment = Enum.TextXAlignment.Left,
            textYAlignment = Enum.TextYAlignment.Bottom,
            textTruncate = Enum.TextTruncate.AtEnd
        })
    else
        element = Roact.createElement(StyledTextLabel, {
            automaticSize = Enum.AutomaticSize.Y,
            colorStyle = var3.Theme.TextEmphasis,
            fontStyle = var3.Font.Header2,
            lineHeight = 1,
            text = var1.contactName,
            textXAlignment = Enum.TextXAlignment.Left,
            textYAlignment = Enum.TextYAlignment.Bottom
        })
    end

    tbl6.contactNameLabel = element
    local var6

    if not var1.hasSentRequest then
        local createElement3 = Roact.createElement
        local var7 = Button
        local tbl7 = {
            buttonType = ButtonType.PrimarySystem,
            position = UDim2.new(1, -1, 0.5, 0),
            anchorPoint = Vector2.new(1, 0.5),
            standardSize = StandardButtonSize.XSmall,
            fitContent = true,
            text = var2.invite,
            isDisabled = var4.isLoading,
            onActivated = var4.sendInvite
        }

        tbl7[React.Change.AbsoluteSize] = function(arg1)
            if getFFlagContactsListEntryUpdatedTruncationFix() then
                var5(0 - (arg1.AbsoluteSize.X + 10))
            end
        end

        var6 = createElement3(var7, tbl7)
    else
        local createElement3 = Roact.createElement
        local var7 = Button
        local tbl7 = {
            buttonType = ButtonType.Secondary,
            position = UDim2.new(1, -1, 0.5, 0),
            anchorPoint = Vector2.new(1, 0.5),
            standardSize = StandardButtonSize.XSmall,
            isDisabled = true,
            text = var2.invite,
            onActivated = Dash.noop
        }

        tbl7[React.Change.AbsoluteSize] = function(arg1)
            if getFFlagContactsListEntryUpdatedTruncationFix() then
                var5(0 - (arg1.AbsoluteSize.X + 10))
            end
        end

        var6 = createElement3(var7, tbl7)
    end

    tbl6.sendInviteButton = var6
    tbl4.entryContent = createElement2(str2, tbl5, tbl6)

    tbl4.divider = if var1.hasDivider then Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = var3.Theme.Divider.Color,
        BackgroundTransparency = var3.Theme.Divider.Transparency
    }) else nil
    return createElement(str1, tbl3, tbl4)
end

return ContactsListInviteEntry
