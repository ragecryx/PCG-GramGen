-- *************************** --
--      Grammar-based PCG      --
-- *************************** --

-- Instructions:
-- 
-- Open a command line app and run
-- premake4 one_of_these__gmake__vs2010__xcode__codeblocks

_ACTION = _ACTION or 'gmake'

--              _   _                 
--             | | (_)                
--   ___  _ __ | |_ _  ___  _ __  ___ 
--  / _ \| '_ \| __| |/ _ \| '_ \/ __|
-- | (_) | |_) | |_| | (_) | | | \__ \
--  \___/| .__/ \__|_|\___/|_| |_|___/
--       | |                          
--       |_| 

-- No options for now...


--            _       _   _                 
--           | |     | | (_)                
--  ___  ___ | |_   _| |_ _  ___  _ __  ___ 
-- / __|/ _ \| | | | | __| |/ _ \| '_ \/ __|
-- \__ \ (_) | | |_| | |_| | (_) | | | \__ \
-- |___/\___/|_|\__,_|\__|_|\___/|_| |_|___/


solution "PCG-Gram"
	configurations { "Debug", "Release" }
	location "./build"
	targetdir "./build"


project "PCG-GramLib"
	kind "SharedLib"
	language "C++"
	location "./build/library"

	includedirs {
		path.getabsolute("./include/")
	}

	files {
		"source/Ruleset.cpp",
		"source/Generator.cpp"
	}

	configuration "Debug"
        defines { "DEBUG" }
        flags { "Symbols" }

    configuration "Release"
        defines { "NDEBUG" }
        flags { "Optimize" }

    configuration { "windows", "codelite" }
        buildoptions { "-std=c++11" }

    configuration { "linux", "gmake" }
        buildoptions { "-std=c++11" }


project "PCG-GramDemo"
	kind "ConsoleApp"
	language "C++"
	location "./build/demo"

	includedirs {
		path.getabsolute("./include/"),
		path.getabsolute("./source_demo/")
	}

	files {
		"source_demo/Main.cpp",
		"source_demo/DemoQuests.cpp",
		"source_demo/DemoWeapons.cpp"
	} -- dot cpp files here

	links { 
		"PCG-GramLib"
	}

	configuration "Debug"
        defines { "DEBUG" }
        flags { "Symbols" }

    configuration "Release"
        defines { "NDEBUG" }
        flags { "Optimize" }

    configuration { "windows" }
    	defines { "WINDOWS_PLATFORM" }

    configuration { "windows", "codelite" }
        buildoptions { "-std=c++11" }

    configuration { "linux", "gmake" }
        buildoptions { "-std=c++11" }
