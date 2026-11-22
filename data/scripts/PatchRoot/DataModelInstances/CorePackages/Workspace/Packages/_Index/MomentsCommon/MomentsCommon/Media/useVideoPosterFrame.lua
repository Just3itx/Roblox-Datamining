-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local React = require(MomentsCommonParent.React)

local VideoService = game:GetService("VideoService")

local Full = Enum.VideoSampleSize.Full

local function useVideoPosterFrame(content: Content)
    local var1, var2 = React.useState(nil)

    React.useEffect(function()
        var2(nil)
        if content == nil then
            return
        end

        local bool1 = false
        task.spawn(function()
            local var3 = nil
            local success, result = pcall(function()
                var3 = VideoService:CreateVideoSamplerAsync(content, { Size = Full })

                return var3:GetSamplesAtTimesAsync({ 0 })
            end)
            if var3 ~= nil then
                pcall(function()
                    var3:Destroy()
                end)
            end
            if bool1 then
                return
            end

            local var4 = if success then result[1] else nil

            if var4 ~= nil and var4.Image ~= nil then
                var2(var4.Image)
            end
        end)

        return function()
            bool1 = true
        end
    end, { content })

    return var1
end

return useVideoPosterFrame
