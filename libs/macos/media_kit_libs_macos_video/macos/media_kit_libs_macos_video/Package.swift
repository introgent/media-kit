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

let libmpvArtifactBase = "https://github.com/introgent/libmpv-darwin-build/releases/download/v0.7.3-woo4/libmpv-xcframeworks_v0.7.3-woo4_macos-universal-video-default"
let libmpvChecksums = [
    "Ass": "68ad6d4e0e760cdfb7144fdd6e14eeb1abc2cc580bc0d09e43833ec0e6763d1b",
    "Avcodec": "bd2092ba87306f932666ed5bdd7ef55cbb924c98cf50d866de91014c2b5e1531",
    "Avfilter": "516b4f5d0d897b69dca6dea960e51d59fc09232e866a2c28a062f0b8d43ee05d",
    "Avformat": "b7d5d4f0fee5e3685b5b2200f1632792aac67188f38269b97c4a4d61f4d8083d",
    "Avutil": "fa74a4fa00f4ea9abcf04c2e26b89884b099d638e2bccc1f78a3232581880176",
    "Dav1d": "8e3a4f023e567eab00bd572d6ed0b025723313104fe8ce8fbeb7c3e44a3969ef",
    "Freetype": "546eeaf2b06485b18c6264e57a0028c398bfda7961f830c961fa2355d38fe2dc",
    "Fribidi": "b9d1695c93478d42d6a7659695f163f538692a59df43f89dd28397a18a36bfe5",
    "Harfbuzz": "fcc3186032e7ccdc2a54b9a16ff874cfc973d0891c04927190d30070a0decd72",
    "Mbedcrypto": "b2a1763cd9c94dc0e412366fc706819631ec4aa7d6243cc22149b80e5a0f9d42",
    "Mbedtls": "9789613bec164218f87b516006cc81efadb82e372c59b057690afa01973f000a",
    "Mbedx509": "ae6f14b1b0daa1ac42b99986da3f345383a7850076e97de9cd9b3832ac212dcb",
    "Mpv": "21acc0227c72ed23825cbb916314f7ad345baf525516ff8ea15e5bac0f4bc07e",
    "Png16": "77af571c60110139561f7d4997cbeb8cbcb34b84dbc6ac8a40528861c110b232",
    "Swresample": "48a46837666bc932891dea1048e55e37f589a9deb75b3624ae731d78cd63c569",
    "Swscale": "d6490117b177e24ff09327d2ea4073fc9ef44f2488a23c044f2c99798bb315f0",
    "Uchardet": "00db1ffd64e74c076fd19243e2b94149f034e99a43ca0f22695311055948afbd",
    "Xml2": "a03bb8712845498143883fe553650204fe1dc3a0b7cc9a4a8f8c94e894146855"
]
let libmpvProductTargets: [String] = ["media_kit_libs_macos_video"] + libmpvTargets

let package = Package(
    name: "media_kit_libs_macos_video",
    platforms: [
        .macOS("10.9")
    ],
    products: [
        .library(name: "media-kit-libs-macos-video", targets: libmpvProductTargets),
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
            name: "media_kit_libs_macos_video",
            dependencies: libmpvTargets.map { framework in .target(name: framework) },
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
