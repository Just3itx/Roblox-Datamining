-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local function makeCameraCFrame(at: vector, vec1: vector): CFrame -- Luacid: unused: defined but never referenced
    return CFrame.lookAt(at, at + vec1)
end

local cFrame = CFrame.lookAt(Vector3.new(0, 0.0936213, -15.755899), Vector3.new(0, 0.0936213, -14.755899))
local tbl1 = {
    [76] = CFrame.lookAt(Vector3.new(4.5928926, 0.37917417, -7.374273), Vector3.new(4.0461125, 0.35952252, -6.537227)),
    [77] = CFrame.lookAt(Vector3.new(4.593966, 0.2791934, -7.375918), Vector3.new(4.047186, 0.25954175, -6.5388722)),
    [88] = cFrame,
    [89] = CFrame.lookAt(Vector3.new(0, -0.2991416, -6.4134803), Vector3.new(0, -0.2991416, -5.4134803)),
    [90] = CFrame.lookAt(Vector3.new(0, 0.10852961, -9.357428), Vector3.new(0, 0.10852961, -8.357428))
}

function module.SetupCamera(arg1, cFrame2: CFrame, num1: number?)
    arg1.CFrame = cFrame2 * ((if num1 then tbl1[num1] else nil) or cFrame)
    arg1.Focus = cFrame2
    arg1.FieldOfView = 5
end

return module
