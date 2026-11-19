-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ArgCheck = require(CorePackages.Workspace.Packages.ArgCheck)

local var1 = require(script.Parent.GetImageSetData)((game:GetService("GuiService"):GetResolutionScale()))

local tbl1 = ({})
for k, value in pairs(var1) do
    ArgCheck.isType(value, "table", "value")
    local tbl2 = {}
    for k2, value2 in pairs(value) do
        if k2 == "ImageSet" then
            tbl2.Image = string.format("rbxasset://textures/ui/ImageSet/%s.png", value2)
        else
            tbl2[k2] = value2
        end
    end
    tbl1[k] = tbl2
end

setmetatable(tbl1, {
    __index = function(_, arg1)
        error(("%q is not a valid member of Images"):format(tostring(arg1)), 2)
    end
})

return tbl1
