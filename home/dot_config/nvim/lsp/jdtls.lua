local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })
local cache_vars = {}

local root_markers1 = {
	-- Multi-module projects
	"mvnw", -- Maven
	"gradlew", -- Gradle
	"settings.gradle", -- Gradle
	"settings.gradle.kts", -- Gradle
	-- Use git directory as last resort for multi-module maven projects
	-- In multi-module maven projects it is not really possible to determine what is the parent directory
	-- and what is submodule directory. And jdtls does not break if the parent directory is at higher level than
	-- actual parent pom.xml so propagating all the way to root git directory is fine
	".git",
}
local root_markers2 = {
	-- Single-module projects
	"build.xml", -- Ant
	"pom.xml", -- Maven
	"build.gradle", -- Gradle
	"build.gradle.kts", -- Gradle
}

local features = {
	-- change this to `true` to enable codelens
	codelens = true,

	-- change this to `true` if you have `nvim-dap`,
	-- `java-test` and `java-debug-adapter` installed
	debugger = true,
}

local function get_jdtls_paths()
	if cache_vars.paths then
		return cache_vars.paths
	end

	local path = {}

	path.data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls"

	local jdtls_install = vim.fn.expand("$MASON/packages/jdtls")

	path.java_agent = jdtls_install .. "/lombok.jar"
	path.launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")

	if vim.fn.has("mac") == 1 then
		path.platform_config = jdtls_install .. "/config_mac"
	elseif vim.fn.has("unix") == 1 then
		path.platform_config = jdtls_install .. "/config_linux"
	elseif vim.fn.has("win32") == 1 then
		path.platform_config = jdtls_install .. "/config_win"
	end

	path.bundles = {}

	---
	-- Include java-test bundle if present
	---
	local java_test_path = vim.fn.expand("$MASON/packages/java-test")

	local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n")

	if java_test_bundle[1] ~= "" then
		vim.list_extend(path.bundles, java_test_bundle)
	end

	---
	-- Include java-debug-adapter bundle if present
	---
	local java_debug_path = vim.fn.expand("$MASON/packages/java-debug-adapter")

	local java_debug_bundle =
		vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n")

	if java_debug_bundle[1] ~= "" then
		vim.list_extend(path.bundles, java_debug_bundle)
	end

	---
	-- configure sts4
	---
	-- local spring_path = require('mason-registry')
	--     .get_package('spring-boot-tools')
	--     :get_install_path() .. '/extension/jars/*.jar'
	-- local spring_bundle = vim.split(vim.fn.glob(spring_path), '\n', {})
	--
	-- if spring_bundle[1] ~= '' then
	--     vim.list_extend(path.bundles, spring_bundle)
	-- end
	vim.list_extend(path.bundles, require("spring_boot").java_extensions())

	---
	-- Useful if you're starting jdtls with a Java version that's
	-- different from the one the project uses.
	---
	path.runtimes = {
		-- Note: the field `name` must be a valid `ExecutionEnvironment`,
		-- you can find the list here:
		-- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		--
		-- This example assume you are using sdkman: https://sdkman.io
		{
			name = "JavaSE-17",
			path = vim.fn.expand("~/.sdkman/candidates/java/17.0.10-tem"),
		},
		{
			name = "JavaSE-21",
			path = vim.fn.expand("~/.sdkman/candidates/java/21.0.2-open"),
		},
	}
	cache_vars.paths = path

	return path
end

local function enable_codelens(bufnr)
	pcall(vim.lsp.codelens.refresh)

	vim.api.nvim_create_autocmd("BufWritePost", {
		buffer = bufnr,
		group = java_cmds,
		desc = "refresh codelens",
		callback = function()
			pcall(vim.lsp.codelens.refresh)
		end,
	})
end

local function enable_debugger(bufnr)
	require("jdtls").setup_dap({ hotcodereplace = "auto" })
	require("jdtls.dap").setup_dap_main_class_configs()

	local opts = { buffer = bufnr }
	vim.keymap.set("n", "<leader>df", "<cmd>lua require('jdtls').test_class()<cr>", opts)
	vim.keymap.set("n", "<leader>dn", "<cmd>lua require('jdtls').test_nearest_method()<cr>", opts)
end

local function jdtls_on_attach(client, bufnr)
	if features.debugger then
		enable_debugger(bufnr)
	end

	if features.codelens then
		enable_codelens(bufnr)
	end

	-- The following mappings are based on the suggested usage of nvim-jdtls
	-- https://github.com/mfussenegger/nvim-jdtls#usage
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "<A-o>", "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
	vim.keymap.set("n", "crv", "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
	vim.keymap.set("x", "crv", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts)
	vim.keymap.set("n", "crc", "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
	vim.keymap.set("x", "crc", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts)
	vim.keymap.set("x", "crm", "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", opts)
	vim.lsp.inlay_hint.enable(true)
end

local path = get_jdtls_paths()
local data_dir = path.data_dir .. "/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local lsp_settings = {
	java = {
		eclipse = {
			downloadSources = true,
		},
		configuration = {
			updateBuildConfiguration = "interactive",
			runtimes = path.runtimes,
		},
		maven = {
			downloadSources = true,
		},
		implementationsCodeLens = {
			enabled = true,
		},
		referencesCodeLens = {
			enabled = true,
		},
		inlayHints = {
			parameterNames = {
				enabled = "all", -- literals, all, none
			},
		},
		format = {
			enabled = true,
		},
	},
	signatureHelp = {
		enabled = true,
	},
	completion = {
		favoriteStaticMembers = {
			"org.hamcrest.MatcherAssert.assertThat",
			"org.hamcrest.Matchers.*",
			"org.hamcrest.CoreMatchers.*",
			"org.junit.jupiter.api.Assertions.*",
			"java.util.Objects.requireNonNull",
			"java.util.Objects.requireNonNullElse",
			"org.mockito.Mockito.*",
		},
	},
	contentProvider = {
		preferred = "fernflower",
	},
	sources = {
		organizeImports = {
			starThreshold = 9999,
			staticStarThreshold = 9999,
		},
	},
	codeGeneration = {
		toString = {
			template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
		},
		useBlocks = true,
	},
}

local cmd = {
	"java",
	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-javaagent:" .. path.java_agent,
	"-Xms1g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",
	"-jar",
	path.launcher_jar,
	"-configuration",
	path.platform_config,
	"-data",
	data_dir,
}

return {
	cmd = cmd,
	on_attach = jdtls_on_attach,
	root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers1, root_markers2 }
		or vim.list_extend(root_markers1, root_markers2),
	settings = lsp_settings,
	init_options = {
		bundles = path.bundles,
	},
}
