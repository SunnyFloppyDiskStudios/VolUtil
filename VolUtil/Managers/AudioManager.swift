//
//  AudioManager.swift
//  VolUtil
//
//  Created by SunnyFlops on 14/07/2025.
//

import Foundation
import CoreAudio

// speakers (ear explosions)
func getDefaultOutputDevice() -> AudioDeviceID? {
    var deviceID = AudioDeviceID(0)
    var propertyAddress = AudioObjectPropertyAddress(
        mSelector: kAudioHardwarePropertyDefaultOutputDevice,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain
    )
    
    var dataSize = UInt32(MemoryLayout<AudioDeviceID>.size)
    let status = AudioObjectGetPropertyData(
        AudioObjectID(kAudioObjectSystemObject),
        &propertyAddress,
        0,
        nil,
        &dataSize,
        &deviceID
    )
    
    return (status == noErr) ? deviceID : nil
}

func setSystemVolume(_ volume: Float32) {
    guard let deviceID = getDefaultOutputDevice() else {
        print("Failed to get default output device")
        return
    }

    let channels: [UInt32] = [1, 2] // L, R
    for channel in channels {
        var volumeToSet = volume
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioDevicePropertyVolumeScalar,
            mScope: kAudioDevicePropertyScopeOutput,
            mElement: channel
        )
        
        guard AudioObjectHasProperty(deviceID, &address) else {
            print("Channel \(channel) not available")
            continue
        }

        let result = AudioObjectSetPropertyData(
            deviceID,
            &address,
            0,
            nil,
            UInt32(MemoryLayout<Float32>.size),
            &volumeToSet
        )

        if result != noErr {
            print("Error setting volume for channel \(channel): \(result)")
        }
    }
}

func getSystemVolume() -> Float32 {
    guard let deviceID = getDefaultOutputDevice() else {
        print("Failed to get default output device")
        return 0
    }

    var leftVolume: Float32 = 0
    var address = AudioObjectPropertyAddress(
        mSelector: kAudioDevicePropertyVolumeScalar,
        mScope: kAudioDevicePropertyScopeOutput,
        mElement: 1
    )
    
    var dataSize = UInt32(MemoryLayout<Float32>.size)

    guard AudioObjectHasProperty(deviceID, &address) else {
        print("Left channel volume not available")
        return 0
    }

    let result = AudioObjectGetPropertyData(
        deviceID,
        &address,
        0,
        nil,
        &dataSize,
        &leftVolume
    )

    if result != noErr {
        print("Error getting volume: \(result)")
        return 0
    }

    return leftVolume
}

// microphone 🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️🗣️
func setInputVolume(_ volume: Float32) {
    guard let deviceID = getDefaultInputDevice() else {
        print("Failed to get default input device")
        return
    }

    let channels: [UInt32] = [1, 2] // L, R
    for channel in channels {
        var volumeToSet = volume
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioDevicePropertyVolumeScalar,
            mScope: kAudioDevicePropertyScopeInput,
            mElement: channel
        )

        guard AudioObjectHasProperty(deviceID, &address) else {
            print("Input channel \(channel) not available")
            continue
        }

        let result = AudioObjectSetPropertyData(
            deviceID,
            &address,
            0,
            nil,
            UInt32(MemoryLayout<Float32>.size),
            &volumeToSet
        )

        if result != noErr {
            print("Error setting input volume for channel \(channel): \(result)")
        }
    }
}

func getInputVolume() -> Float32 {
    guard let deviceID = getDefaultInputDevice() else {
        print("Failed to get default input device")
        return 0
    }

    var inputVolume: Float32 = 0
    var address = AudioObjectPropertyAddress(
        mSelector: kAudioDevicePropertyVolumeScalar,
        mScope: kAudioDevicePropertyScopeInput,
        mElement: 1 // L, don't think there's an R
    )

    var dataSize = UInt32(MemoryLayout<Float32>.size)

    guard AudioObjectHasProperty(deviceID, &address) else {
        print("Input channel 1 not available")
        return 0
    }

    let result = AudioObjectGetPropertyData(
        deviceID,
        &address,
        0,
        nil,
        &dataSize,
        &inputVolume
    )

    if result != noErr {
        print("Error getting input volume: \(result)")
        return 0
    }

    return inputVolume
}

private func getDefaultInputDevice() -> AudioDeviceID? {
    var deviceID = AudioDeviceID(0)
    var propertyAddress = AudioObjectPropertyAddress(
        mSelector: kAudioHardwarePropertyDefaultInputDevice,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain
    )

    var dataSize = UInt32(MemoryLayout<AudioDeviceID>.size)
    let status = AudioObjectGetPropertyData(
        AudioObjectID(kAudioObjectSystemObject),
        &propertyAddress,
        0,
        nil,
        &dataSize,
        &deviceID
    )

    return (status == noErr) ? deviceID : nil
}

func inputVolumeAdjustable() -> Bool {
    guard let deviceID = getDefaultInputDevice() else { return false }

    var address = AudioObjectPropertyAddress(
        mSelector: kAudioDevicePropertyVolumeScalar,
        mScope: kAudioDevicePropertyScopeInput,
        mElement: 1
    )

    return AudioObjectHasProperty(deviceID, &address)
}
