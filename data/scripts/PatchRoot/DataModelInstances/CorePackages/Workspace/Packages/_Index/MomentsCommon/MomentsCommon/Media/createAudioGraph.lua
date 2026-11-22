-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local audioDuckingFastInts = require(MomentsCommon.Media.audioDuckingFastInts)

local function createAudioGraph(parent, targetInstance, tbl1)
    local tbl2 = tbl1 or {}

    local volume = if tbl2.masterVolume == nil then 0.2 else tbl2.masterVolume
    local bool1 = tbl2.enableDucking == true

    local masterFader = Instance.new("AudioFader")
    masterFader.Name = "MasterFader"
    masterFader.Volume = volume
    masterFader.Parent = parent

    local wire = Instance.new("Wire")
    wire.SourceInstance = masterFader
    wire.TargetInstance = targetInstance
    wire.Parent = masterFader

    local var2 = nil
    if bool1 then
        local compressorParams = audioDuckingFastInts.getCompressorParams()
        local duckCompressor = Instance.new("AudioCompressor")
        duckCompressor.Name = "DuckCompressor"
        duckCompressor.Threshold = compressorParams.threshold
        duckCompressor.Ratio = compressorParams.ratio
        duckCompressor.Attack = compressorParams.attack
        duckCompressor.Release = compressorParams.release
        duckCompressor.MakeupGain = compressorParams.makeupGain
        duckCompressor.Parent = parent
        var2 = duckCompressor

        local wire2 = Instance.new("Wire")
        wire2.SourceInstance = duckCompressor
        wire2.TargetInstance = masterFader
        wire2.Parent = duckCompressor
    end

    local tbl3 = ({})
    local getMasterMuted = false

    local bool3 = false

    local function applyStem(tbl4) -- Luacid: Inlined by compiler; 2 call sites recovered
        tbl4.fader.Volume = if tbl4.muted then 0 else tbl4.targetVolume
    end

    local function removeStem(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        local var3 = tbl3[str1]
        if not var3 then
            return
        end
        tbl3[str1] = nil

        var3.fader:Destroy()
    end

    return {
        addStem = function(str1: string, sourceInstance, num1: number?, str2: string?)
            assert(not bool3, "createAudioGraph: addStem after dispose")
            assert(not tbl3[str1], `createAudioGraph: stem "{str1}" already added`)

            local num2 = num1 or 1

            local audioFader = Instance.new("AudioFader")
            audioFader.Name = `Stem_{str1}`
            audioFader.Volume = num2
            audioFader.Parent = parent

            local wire2 = Instance.new("Wire")
            wire2.SourceInstance = sourceInstance
            wire2.TargetInstance = audioFader
            wire2.Parent = audioFader

            if bool1 and (str2 or "input") == "sidechain" then
                local wire3 = Instance.new("Wire")
                wire3.SourceInstance = audioFader
                wire3.TargetInstance = masterFader
                wire3.Parent = audioFader

                local wire4 = Instance.new("Wire")
                wire4.SourceInstance = sourceInstance
                wire4.TargetInstance = var2
                wire4.TargetName = "Sidechain"
                wire4.Parent = audioFader
            elseif bool1 then
                local wire3 = Instance.new("Wire")
                wire3.SourceInstance = audioFader
                wire3.TargetInstance = var2
                wire3.Parent = audioFader
            else
                local wire3 = Instance.new("Wire")
                wire3.SourceInstance = audioFader
                wire3.TargetInstance = masterFader
                wire3.Parent = audioFader
            end

            tbl3[str1] = { fader = audioFader, targetVolume = num2, muted = false }

            return function()
                removeStem(str1)
            end
        end,
        setVolume = function(str1: string, targetVolume: number)
            assert(not bool3, "createAudioGraph: setVolume after dispose")
            local var3 = tbl3[str1]
            assert(var3, `createAudioGraph: no stem "{str1}"`)
            var3.targetVolume = targetVolume
            applyStem(var3)
        end,
        setMuted = function(str1: string, muted: boolean)
            assert(not bool3, "createAudioGraph: setMuted after dispose")
            local var3 = tbl3[str1]
            assert(var3, `createAudioGraph: no stem "{str1}"`)
            var3.muted = muted
            applyStem(var3)
        end,
        setMasterMuted = function(bool4: boolean)
            assert(not bool3, "createAudioGraph: setMasterMuted after dispose")
            getMasterMuted = bool4
            masterFader.Volume = if bool4 then 0 else volume
        end,
        getMasterMuted = function()
            return getMasterMuted
        end,
        getOutput = function()
            return targetInstance
        end,
        dispose = function()
            if bool3 then
                return
            end
            bool3 = true
            for _, value in tbl3 do
                value.fader:Destroy()
            end
            table.clear(tbl3)

            if var2 ~= nil then
                var2:Destroy()
            end

            masterFader:Destroy()
        end
    }
end
return createAudioGraph
