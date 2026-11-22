-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local MediaGallery = script:FindFirstAncestor("MediaGallery")
local MediaGalleryParent = MediaGallery.Parent

local React = require(MediaGalleryParent.React)
local getIsInstanceVisible = require(MediaGalleryParent.VideoUtils).getIsInstanceVisible

local MediaGalleryConstants = require(MediaGallery.MediaGalleryConstants)
local VIDEO_VISIBLE_PERCENT = MediaGalleryConstants.VIDEO_VISIBLE_PERCENT
local VISIBILITY_SCAN_DEBOUNCE_SEC = MediaGalleryConstants.VISIBILITY_SCAN_DEBOUNCE_SEC

local function useGuiObjectVisibility(tbl1, bool1: boolean, callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?)
    local var1 = React.useRef(nil)

    React.useEffect(function()
        if not (bool1 and tbl1.current) then
            return nil
        end

        local current = tbl1.current

        local tbl2 = {}
        local var2 = nil
        local num1 = 0

        local function getViewportBounds() -- Luacid: Inlined by compiler; 5 call sites recovered
            local currentCamera = workspace.CurrentCamera

            if currentCamera then
                return {
                    min = Vector2.new(0, 0),
                    max = currentCamera.ViewportSize
                }
            end

            return nil
        end

        local function isVisible() -- Luacid: Inlined by compiler; 4 call sites recovered
            local viewportBounds = getViewportBounds()

            if not viewportBounds then
                return false
            end
            return getIsInstanceVisible(current, viewportBounds, VIDEO_VISIBLE_PERCENT)
        end

        local var3 = nil

        local function disconnectRenderStep() -- Luacid: Inlined by compiler; 2 call sites recovered
            if not var1.current then
                return
            end

            var1.current:Disconnect()
            var1.current = nil
            if callback2 then
                callback2()
            end
        end

        local function disconnectLayoutSignals()
            for _, value in tbl2 do
                value:Disconnect()
            end
            tbl2 = {}
            if var2 then
                task.cancel(var2)
                var2 = nil
            end
        end

        local function func1()
            if var1.current then
                return
            end

            disconnectLayoutSignals()

            var1.current = RunService.RenderStepped:Connect(function(deltaTime: number)
                if isVisible() then
                    if callback then
                        callback(deltaTime)
                    end
                else
                    disconnectRenderStep()
                    var3()
                end
            end)
        end

        var3 = function()
            if #tbl2 > 0 then
                return
            end

            local function onLayoutChange()
                if var2 then
                    return
                end
                local num2 = math.max(0, num1 + VISIBILITY_SCAN_DEBOUNCE_SEC - tick())
                if not (num2 > 0) then
                    num1 = tick()

                    if isVisible() then
                        func1()
                    end

                    return
                end

                var2 = task.delay(num2, function()
                    var2 = nil
                    num1 = tick()

                    if isVisible() then
                        func1()
                    end
                end)
            end

            tbl2 = { current:GetPropertyChangedSignal("AbsolutePosition"):Connect(onLayoutChange), current:GetPropertyChangedSignal("AbsoluteSize"):Connect(onLayoutChange) }
        end

        if isVisible() then
            func1()
        else
            var3()
        end

        return function()
            disconnectLayoutSignals()
            disconnectRenderStep()
        end
    end, {
        bool1,
        tbl1,
        callback,
        callback2
    })
end
return useGuiObjectVisibility
