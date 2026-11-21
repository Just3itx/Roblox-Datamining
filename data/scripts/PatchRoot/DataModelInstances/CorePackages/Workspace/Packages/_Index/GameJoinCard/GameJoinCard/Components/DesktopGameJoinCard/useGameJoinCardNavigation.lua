-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent
local React = require(GameJoinCardParent.React)

local FFlagBlockEDPClickthrough = require(GameJoinCardParent.SharedFlags).FFlagBlockEDPClickthrough

local function useGameJoinCardNavigation(ancestor: Instance, bool1: boolean, arg1)
    local var1, var2 = React.useState(false)

    React.useEffect(function()
        if not ancestor then
            var2(false)
            return
        end

        local GuiService = game:GetService("GuiService")
        local function checkFocus() -- Luacid: Inlined by compiler; 1 call site recovered
            local selectedCoreObject = GuiService.SelectedCoreObject
            var2(
                not (selectedCoreObject == nil)
                    and (selectedCoreObject == ancestor or selectedCoreObject:IsDescendantOf(ancestor))
                    and selectedCoreObject:FindFirstAncestorOfClass("CoreGui") ~= nil
            )
        end

        checkFocus()
        local connection = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(checkFocus)
        return function()
            connection:Disconnect()
        end
    end, { ancestor })

    React.useEffect(function()
        if not bool1 or not ancestor then
            return
        end

        local current = arg1.current
        if not current then
            return
        end
        local content = current:FindFirstChild("Content", true)
        if not content then
            return
        end

        local function wireNavigation()
            if FFlagBlockEDPClickthrough then
                local platformName = ancestor:FindFirstChild("PlatformName", true)
                if platformName then
                    content.NextSelectionDown = platformName
                    platformName.NextSelectionUp = content
                end
                return
            end

            local thumbnail = ancestor:FindFirstChild("Thumbnail", true)
            local gameName = ancestor:FindFirstChild("GameName", true)
            local platformName = ancestor:FindFirstChild("PlatformName", true)
            if thumbnail then
                content.NextSelectionDown = thumbnail
                thumbnail.NextSelectionUp = content
            end
            if gameName then
                gameName.NextSelectionUp = content
            end
            if not platformName then
                return
            end

            platformName.NextSelectionUp = gameName or content
            if gameName then
                gameName.NextSelectionDown = platformName
            end
        end

        wireNavigation()
        local connection = ancestor.DescendantAdded:Connect(wireNavigation)

        return function()
            connection:Disconnect()
            if content and content.Parent then
                content.NextSelectionDown = nil
            end
            if not FFlagBlockEDPClickthrough then
                local thumbnail = ancestor:FindFirstChild("Thumbnail", true)
                if thumbnail and thumbnail.Parent then
                    thumbnail.NextSelectionUp = nil
                end
                local gameName = ancestor:FindFirstChild("GameName", true)
                if gameName and gameName.Parent then
                    gameName.NextSelectionUp = nil
                    gameName.NextSelectionDown = nil
                end
            end
            local platformName = ancestor:FindFirstChild("PlatformName", true)
            if platformName and platformName.Parent then
                platformName.NextSelectionUp = nil
                platformName.NextSelectionDown = nil
            end
        end
    end, { ancestor, bool1 })

    return var1
end

return useGameJoinCardNavigation
