-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local IXPService = game:GetService("IXPService")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local React = require(ServerDrivenUiParent.React)
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)

local _SduiCompat = require(ServerDrivenUiParent.SduiCompat)
local SduiContentRow = require(ServerDrivenUiParent.SduiSharedContent).SduiContentRow

local AgeCheckUpsellDismissedData = require(ServerDrivenUiParent.GameDetail).AgeCheckUpsellDismissedData

local bool1 = game:DefineFastFlag("LuaAppEdpFaeIxpEnabled", false)
local layerName = game:DefineFastString("LuaAppEdpFaeIxpLayer", "PlayerApp.GameDetailsPage.Exposure")

return React.memo(function(tbl1) -- name: SduiAgeCheckUpsellRow
    local var1 = SignalsReact.useSignalState(AgeCheckUpsellDismissedData.getIsAgeCheckUpsellDismissed)

    if bool1 then
        React.useEffect(function()
            if not var1 then
                IXPService:LogFlagLinkedUserLayerExposure(layerName)
            end
        end, { var1 })
    end

    if var1 then
        return nil
    end

    return React.createElement(SduiContentRow, tbl1)
end)
