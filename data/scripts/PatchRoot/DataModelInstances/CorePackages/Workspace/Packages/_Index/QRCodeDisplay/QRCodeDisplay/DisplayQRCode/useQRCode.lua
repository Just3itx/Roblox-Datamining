-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local QRCodeDisplay = script:FindFirstAncestor("QRCodeDisplay")
local QRCodeDisplayParent = QRCodeDisplay.Parent
local React = require(QRCodeDisplayParent.React)
local QRCode = require(QRCodeDisplayParent.QRCode)
local ecToNumber = require(script.Parent.ecToNumber)
local _ECLevels = require(QRCodeDisplay.Common.ECLevels)

return function(tbl1)
    return React.useMemo(function()
        local _, var1 = QRCode.qrcode(tbl1.toEncode, ecToNumber(tbl1.ecLevel))

        return var1
    end, { tbl1.toEncode, tbl1.ecLevel })
end
