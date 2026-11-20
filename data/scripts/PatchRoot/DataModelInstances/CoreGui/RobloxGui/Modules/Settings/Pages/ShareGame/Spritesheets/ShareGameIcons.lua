-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createFrameModel(offset: Vector2, size: Vector2) -- Luacid: Inlined by compiler; 9 call sites recovered
    return { offset = offset, size = size }
end

local tbl1 = {
    frames = {
        back = createFrameModel(Vector2.new(2, 19), Vector2.new(24, 24)),
        clear = createFrameModel(Vector2.new(6, 51), Vector2.new(16, 16)),
        invite = createFrameModel(Vector2.new(2, 75), Vector2.new(24, 24)),
        search_border = createFrameModel(Vector2.new(11, 1), Vector2.new(7, 7)),
        search_large = createFrameModel(Vector2.new(3, 132), Vector2.new(22, 22)),
        search_small = createFrameModel(Vector2.new(6, 106), Vector2.new(16, 16)),
        friends = createFrameModel(Vector2.new(0, 159), Vector2.new(72, 72)),
        cross = createFrameModel(Vector2.new(4, 231), Vector2.new(24, 24)),
        modal_border = createFrameModel(Vector2.new(0, 255), Vector2.new(7, 7))
    }
}

local module = {}

function module.GetFrame(_, arg1)
    return tbl1.frames[arg1]
end

function module.GetImagePath(_): string
    return "rbxasset://textures/ui/Settings/ShareGame/icons.png"
end

function module.ApplyImage(arg1, arg2, arg3)
    local frame = arg1:GetFrame(arg3)

    arg2.Image = "rbxasset://textures/ui/Settings/ShareGame/icons.png"
    arg2.ImageRectOffset = frame.offset
    arg2.ImageRectSize = frame.size
end

return module
