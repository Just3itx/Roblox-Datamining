-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent

local React = require(InlineRichTextParent.React)

local useNavigateToWebview = require(InlineRichText.Linker.Behaviors.useNavigateToWebview)
local useInvokeLinkingProtocol = require(InlineRichText.Linker.Behaviors.useInvokeLinkingProtocol)
local useShowErrorToast = require(InlineRichText.Linker.Behaviors.useShowErrorToast)
local LinkBehavior = require(InlineRichText.Enums.LinkBehavior)
local var1 = require(InlineRichText.Logger):new(script.Name)

local _Types = require(InlineRichText.Types)

local function useLinkerOnActivated(tbl1)
    local var2 = useNavigateToWebview()
    local var3 = useInvokeLinkingProtocol()
    local var4 = useShowErrorToast({ errorToastTextOverride = tbl1.errorToastTextOverride })

    local tbl2 = {
        [LinkBehavior.Webview] = var2,
        [LinkBehavior.LinkingProtocol] = var3,
        [LinkBehavior.ErrorToast] = var4
    }

    return (React.useCallback(function(arg1)
        local var5 = tbl2[arg1.linkBehavior]
        if var5 then
            var5(arg1.url)
            return
        end
        var1:error(
            `Link activation failed with invalid link behavior: {arg1.linkBehavior}. This behavior is either invalid or doesn't support activation.`
        )
    end, { tbl2 }))
end

return useLinkerOnActivated
