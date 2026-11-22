-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local QRCodeDisplay = script:FindFirstAncestor("QRCodeDisplay")
local QRCodeDisplayParent = QRCodeDisplay.Parent
local React = require(QRCodeDisplayParent.React)
local Dash = require(QRCodeDisplayParent.Dash)
local DisplayQRCodeFromMatrix = require(script.Parent.Parent.DisplayQRCodeFromMatrix.DisplayQRCodeFromMatrix)
local _ECLevels = require(QRCodeDisplay.Common.ECLevels)
local useQRCode = require(script.Parent.useQRCode)

return function(tbl1)
    local tbl2 = {
        qrCodeMatrix = useQRCode(tbl1)
    }
    return React.createElement(DisplayQRCodeFromMatrix, Dash.join(tbl1, tbl2))
end
