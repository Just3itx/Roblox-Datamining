-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function waitForFirst(...)
    local bindableEvent = Instance.new("BindableEvent")
    local tbl1 = { ... }

    local function fire(...)
        for i = 1, #tbl1 do
            tbl1[i]:Disconnect()
        end

        return bindableEvent:Fire(...)
    end

    for i = 1, #tbl1 do
        tbl1[i] = tbl1[i]:Connect(fire)
    end

    return bindableEvent.Event:Wait()
end

return waitForFirst
