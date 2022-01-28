require("clean")
VULKAN_SDK = os.getenv("VULKAN_SDK")

workspace "VulkanSponza"
  systemversion "latest"
	configurations
	{
		"Debug",
		"Release",
	}
	architecture "x86_64"
	startproject "VulkanSponza"

include "external/assimp"

project "VulkanSponza"
	kind          "ConsoleApp"
  language      "C++"
	cppdialect    "C++11"
	staticruntime "off"
	location 			"src"

  targetdir "%{wks.location}/bin/%{cfg.buildcfg}/%{prj.name}"
	objdir    "%{wks.location}/build/%{cfg.buildcfg}/%{prj.name}"

	flags
	{
		"MultiProcessorCompile"
	}

  files
	{
    "src/**.h",
		"src/**.cpp",
		"base/**.cpp",
	}

  defines
	{
    "NOMINMAX",
		"_USE_MATH_DEFINES",
		"_CRT_SECURE_NO_WARNINGS",
		"VK_USE_PLATFORM_WIN32_KHR",
	}

  includedirs
	{
    "src",
		"external",
		"external/glm",
		"external/gli",
		"external/assimp/include",
		"base",
		
		"%{VULKAN_SDK}/Include"
  }

	libdirs 
	{
		--"assimp",
		--"%{wks.location}/libs/assimp",
		--"%{wks.location}/libs/vulkan",
		"%{VULKAN_SDK}/Lib"
	}


	postbuildcommands
	{
		--"{COPYDIR} \"%{VULKAN_SDK}/Lib\" \"%{cfg.targetdir}\""
	}


	links { 
		"%{VULKAN_SDK}/Lib/vulkan-1.lib",
		"assimp",
	}

	filter "configurations:Debug"
		defines { "DEBUG" }
		buildoptions "/MDd"
		symbols "on"
		

	filter "configurations:Release"
		defines { "NDEBUG" }
		buildoptions "/MD"
		optimize "on"

