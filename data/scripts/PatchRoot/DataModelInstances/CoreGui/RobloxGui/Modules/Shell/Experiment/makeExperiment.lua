-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")

local function makeExperiment(str1: string, str2: string, str3: string, str4: string, str5: string)
    for _, value in {
        str1,
        str2,
        str3,
        str4,
        str5
    } do
        if not IXPService[value] then
            error("makeExperiment factory expects configured members to exist on IXPService. Member " .. value .. " not found")
        end
    end

    return function(arg1, tbl1, func1: (...any) -> (...any), bool1: boolean?)
        if bool1 == nil then
            bool1 = true
        end

        assert(type(tbl1) == "table", "makeExperiment expects layerNames to be a list of layers")
        assert(type(func1) == "function", "makeExperiment expects mapLayers to be a function")

        local function updateStateLayerData(layerLoadingStatus: string)
            local layerToVariables = ({})
            for _, value in ipairs(tbl1) do
                layerToVariables[value] = IXPService[str3](IXPService, value)
            end

            func1({ layerToVariables = layerToVariables, layerLoadingStatus = layerLoadingStatus })
        end

        local function logAllLayersExposure()
            for _, value in ipairs(tbl1) do
                if IXPService[str5](IXPService, value) == Enum.IXPLoadingStatus.Initialized then
                    IXPService[str4](IXPService, value)
                end
            end
        end

        updateStateLayerData((IXPService[str2](IXPService)))

        local connection = IXPService[str1]:Connect(function()
            local layerLoadingStatus = IXPService[str2](IXPService)
            updateStateLayerData(layerLoadingStatus)

            if bool1 and layerLoadingStatus == Enum.IXPLoadingStatus.Initialized then
                logAllLayersExposure()
            end
        end)

        arg1.Destroying:Once(function()
            connection:Disconnect()
        end)

        return connection
    end
end

return makeExperiment
