// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let libmpvTargets = [
    "Ass",
    "Avcodec",
    "Avfilter",
    "Avformat",
    "Avutil",
    "Dav1d",
    "Freetype",
    "Fribidi",
    "Harfbuzz",
    "Mbedcrypto",
    "Mbedtls",
    "Mbedx509",
    "Mpv",
    "Png16",
    "Swresample",
    "Swscale",
    "Uchardet",
    "Xml2"
]

let libmpvArtifactBase = "https://github.com/introgent/libmpv-darwin-build/releases/download/v0.7.3-woo4/libmpv-xcframeworks_v0.7.3-woo4_ios-universal-video-default"
let libmpvChecksums = [
    "Ass": "bf304162124dafdf3d4690d8eb0fa717db4107ef5cc28719f2a26f259c4d5e0d",
    "Avcodec": "bbc5f9af9274f1417c57fbfe9dab43ef3acf9884c995c571ea70376bd549b295",
    "Avfilter": "5a79e70e18b9bb5878a9369b01ca6dcce5d5adbcf61b5ea031a344e200fba4ea",
    "Avformat": "45c1b0fd8ca419f2b9e29cff79c52dc38a6420ff263948e217b2d1a259ecda59",
    "Avutil": "dfa7175f52fe21f7febcef13eb4b46ad7495c59e2114d2508edbed7fc66e01ad",
    "Dav1d": "5e131ca946544b6c9c8c018135e40bc3cfca4bdacf11de6d33c0ddf6fc9d324c",
    "Freetype": "9bf4347eedde88210d08a1b927a447bdacc01163696f31f3c4ede74c38806806",
    "Fribidi": "5a929d9f119dffc362e2b3fc91767a85fdccc66afbc7800d157a6b21ab7fc5f3",
    "Harfbuzz": "4ddece242fffade52e14a511ba3c169a7fe1c83f3ea6f736e0f94d9802df396d",
    "Mbedcrypto": "47b88b457d7a7e278e994bf596d255089b5cd10e83bdfa29fbc5d6f0547f8444",
    "Mbedtls": "7d5aa3cb30b73f31800e4472845e9ebd9c50d0c2511a3129c8ee4e09cc05c0fc",
    "Mbedx509": "e3ae78f2591293c5a7b0c8c33fdd446bd27cda100900c0e75343e45680ff57ac",
    "Mpv": "d02ba1e857d6a44f71b07afe0fe380f1fc5e6c05a28ce076f2b8b99543357806",
    "Png16": "b68234933b794ac4416d9d65caa9b8ab695a0da51ca1b4823f675bbeffcf1ab7",
    "Swresample": "d40e3104318f94a6f5cbf91fabe221b0a9d20f3adf7027893af2232eeb273c2f",
    "Swscale": "1370e8b1bbdf41fe16b2cb41a20a23194546a877a205a0b40de5b9583501ce99",
    "Uchardet": "359e4422a77c79d44a507e93cb6bc7ef58c400f0327cffe0a93c0ed01238fbe4",
    "Xml2": "b67ae18d4fe12c0ad986606ffb906e92bd1ade5616215b0a5180e44d74be4001"
]
let libmpvProductTargets: [String] = ["media_kit_libs_ios_video"] + libmpvTargets

let package = Package(
    name: "media_kit_libs_ios_video",
    platforms: [
        .iOS("9.0")
    ],
    products: [
        .library(name: "media-kit-libs-ios-video", targets: libmpvProductTargets),
        .library(name: "Mpv", targets: ["Mpv"])
    ],
    dependencies: [],
    targets: libmpvTargets.map { framework in
        .binaryTarget(
            name: framework,
            url: "\(libmpvArtifactBase)_\(framework).zip",
            checksum: libmpvChecksums[framework]!
        )
    } + [
        .target(
            name: "media_kit_libs_ios_video",
            dependencies: libmpvTargets.map { framework in .target(name: framework) },
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
