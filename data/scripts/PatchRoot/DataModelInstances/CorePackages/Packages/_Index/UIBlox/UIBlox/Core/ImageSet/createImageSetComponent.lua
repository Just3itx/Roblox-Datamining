-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Roact = require(scriptParentParentParentParent.Roact)
local uiblox = require(scriptParentParentParentParent.BuilderIcons).Migration.uiblox
local Foundation = require(scriptParentParentParentParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local useTextSizeOffset = Foundation.Hooks.useTextSizeOffset
local scaleSliceToResolution = require(scriptParentParentParent.App.ImageSet.scaleSliceToResolution)
local ImagesInverse = require(scriptParentParentParent.App.ImageSet.ImagesInverse)
local getBuilderIconElement = require(scriptParent.getBuilderIconElement)

return function(arg1, arg2)
    assert(arg2 > 0, "resolutionScale for ImageSet must be greater than 0! got " .. tostring(arg2))

    return Roact.forwardRef(function(arg3, arg4)
        local tbl1 = {
            [Roact.Ref] = arg4,
            [Roact.Children] = arg3[Roact.Children]
        }
        local var1 = nil
        local image = nil
        local bool1 = false
        local bool2 = false

        for k, value in pairs(arg3) do
            if k ~= "Image" or typeof(value) ~= "table" then
                tbl1[k] = value
            elseif uiblox[value.Image] then
                image = value.Image
                bool2 = true
            else
                var1 = value
                bool1 = true
            end
        end
        local var2 = useTokens()
        local var3 = useTextSizeOffset()
        if bool1 or bool2 then
            if not bool2 then
                image = ImagesInverse[var1]
            end

            if image and uiblox[image] then
                if not var2.Stroke then
                    error(
                        `No StyleProvider in tree for migrated icon ImageSetComponent.\n UIBlox Icon: {image}, BuilderIcon: {uiblox[image]}`
                    )
                end
                local standard = var2.Stroke.Standard
                return getBuilderIconElement(tbl1, arg1, uiblox[image], image, var2, var3, standard)
            end
        end

        if bool1 then
            for k, value in pairs(var1) do
                if not tbl1[k] then
                    tbl1[k] = value
                elseif k == "ImageRectOffset" then
                    tbl1[k] = value + tbl1[k] * arg2
                elseif k == "ImageRectSize" then
                    tbl1[k] *= arg2
                end
            end
        end

        if bool1 then
            tbl1 = scaleSliceToResolution(tbl1, arg2)
        end

        return Roact.createElement(arg1, tbl1)
    end)
end
