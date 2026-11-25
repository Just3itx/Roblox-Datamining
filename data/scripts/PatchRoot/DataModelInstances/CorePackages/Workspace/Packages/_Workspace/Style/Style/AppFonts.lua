-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(_enableNewFont: boolean)
    local tbl1 = { _enableNewFont = _enableNewFont }

    setmetatable(tbl1, module)
    return tbl1
end

function module:getDefault(): Enum.Font
    return if self._enableNewFont then Enum.Font.BuilderSans else Enum.Font.Gotham
end

function module:getMedium(): Enum.Font
    return if self._enableNewFont then Enum.Font.BuilderSansMedium else Enum.Font.GothamMedium
end

function module:getBlack(): Enum.Font
    return if self._enableNewFont then Enum.Font.BuilderSansExtraBold else Enum.Font.GothamBlack
end

function module:getBold(): Enum.Font
    return if self._enableNewFont then Enum.Font.BuilderSansBold else Enum.Font.GothamBold
end

function module:getSemibold(): Enum.Font
    return if self._enableNewFont then Enum.Font.BuilderSansMedium else Enum.Font.GothamMedium
end

module.default = module.new(true)
return module
