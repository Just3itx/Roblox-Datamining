-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local RunService = game:GetService("RunService")
local InlineRichTextParent = InlineRichText.Parent

local React = require(InlineRichTextParent.React)
local LinkingProtocol = require(InlineRichTextParent.LinkingProtocol)
local DeepLinkSource = LinkingProtocol.Enums.DeepLinkSource
local default = LinkingProtocol.LinkingProtocol.default

local var1 = require(InlineRichText.Logger):new(script.Name)

local _Types = require(InlineRichText.Types)
local isStudio = RunService:IsStudio()

return function(_: nil)
    return React.useCallback(function(str1: string)
        default:isURLRegistered(str1):andThen(function(arg1)
            if not arg1 then
                default:openURL(str1):catch(function(arg2)
                    var1:error("Failed to open URL: ", str1, " with error: ", arg2)
                end)

                return
            end

            if isStudio then
                print(`[OnActivated Debug] Detected URL with LinkingProtocol: {str1}`)
            end
            if default:isInternalDlicEnabled() then
                local var2 = default:createInternalDlic(str1, DeepLinkSource.LuaInternal)
                default:detectDeeplinkIntent(var2)
                return
            end
            default:detectURL(str1)
        end)
    end, {})
end
