-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReportingParent = script:FindFirstAncestor("ChatLineReporting").Parent

local React = require(ChatLineReportingParent.React)
local Foundation = require(ChatLineReportingParent.Foundation)
local UIBlox = require(ChatLineReportingParent.UIBlox)

local ButtonStack = UIBlox.App.Button.ButtonStack
local HeaderBar = UIBlox.App.Bar.HeaderBar
local IconButton = Foundation.IconButton
local ModalWindow = UIBlox.App.Dialog.Modal.ModalWindow
local View = Foundation.View

local function ChatLineReportModalWindow(tbl1)
    local bool1 = not not tbl1.buttonStackProps

    return React.createElement(
        ModalWindow,
        {
            isFullHeight = false,
            screenSize = tbl1.screenSize,
            position = tbl1.position,
            anchorPoint = tbl1.anchorPoint
        },
        {
            Content = React.createElement(View, {
                tag = {
                    ["size-full-0 auto-y col"] = true,
                    ["padding-bottom-small"] = not bool1,
                    ["padding-bottom-xxlarge"] = bool1
                }
            }, {
                TitleContainer = React.createElement(HeaderBar, {
                    title = tbl1.title,
                    renderLeft = function()
                        return React.createElement(IconButton, { icon = "icons/navigation/close", onActivated = tbl1.onCloseClicked })
                    end,
                    renderRight = function()
                        return React.createElement(IconButton, { icon = "icons/actions/info", onActivated = tbl1.onInfoClicked })
                    end,
                    backgroundTransparency = 1,
                    margin = 10
                }),
                Underline = React.createElement(View, { tag = "size-full-0 stroke-standard stroke-default", LayoutOrder = 1 }),
                MiddleContent = React.createElement(View, { tag = "size-full-0 auto-y padding-x-xxlarge", LayoutOrder = 2 }, tbl1.children),
                Buttons = bool1
                    and React.createElement(
                        View,
                        { tag = "size-full-0 padding-x-xxlarge auto-y", LayoutOrder = 3 },
                        React.createElement(ButtonStack, tbl1.buttonStackProps)
                    )
            })
        }
    )
end

return ChatLineReportModalWindow
