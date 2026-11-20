-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local ContentProvider = game:GetService("ContentProvider")

local React = require(MomentsCommonParent.React)

local Signal = require(MomentsCommon.Utils.Signal)

local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef
local useToggleState = require(MomentsCommon.Hooks.useToggleState)

local function useImageDisplay(_: boolean, content)
    local ref = useRef(nil)
    local var2 = useRef(nil)

    local isLoadedRef = useRef(false)

    local onImageLoadedSignalRef = useRef(Signal.new())

    local var5 = useToggleState(false)

    useEffect(function()
        local current = ref.current
        if not current then
            return
        end

        if not content then
            return
        end

        isLoadedRef.current = false

        if content.SourceType == Enum.ContentSourceType.Uri then
            var2.current = content.Uri
            task.spawn(function()
                ContentProvider:PreloadAsync({ content.Uri }, function(_, assetFetchStatus)
                    if var2.current ~= content.Uri then
                        return
                    end

                    if assetFetchStatus == Enum.AssetFetchStatus.Success then
                        isLoadedRef.current = true
                        onImageLoadedSignalRef.current:fire()
                    end
                end)
            end)
        end

        if content.SourceType == Enum.ContentSourceType.Object then
            isLoadedRef.current = true
            onImageLoadedSignalRef.current:fire()
        end

        current.ImageContent = content
    end, { var5.enabled, content })

    return {
        isLoadedRef = isLoadedRef,
        onImageLoadedSignalRef = onImageLoadedSignalRef,
        ref = ref,
        updateRef = useCallback(function(current)
            var5.toggle()
            ref.current = current
        end, { var5.toggle })
    }
end

return useImageDisplay
