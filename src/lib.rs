use zed_extension_api::{self as zed, settings::LspSettings, LanguageServerId, Result};

struct ClarityExtension {
    // ... state
}

impl zed::Extension for ClarityExtension {
    fn new() -> Self {
        Self {}
    }

    fn language_server_command(
        &mut self,
        _language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        match worktree.which("clarinet") {
            Some(path) => Ok(zed::Command {
                command: path,
                args: vec!["lsp".into()],
                env: vec![],
            }),
            None => Err("Could not find 'clarinet' binary in PATH. Install from https://github.com/hirosystems/clarinet".into()),
        }
    }

    fn language_server_initialization_options(
        &mut self,
        server_id: &LanguageServerId,
        worktree: &zed_extension_api::Worktree,
    ) -> Result<Option<zed_extension_api::serde_json::Value>> {
        let settings = LspSettings::for_worktree(server_id.as_ref(), worktree)
            .ok()
            .and_then(|lsp_settings| lsp_settings.initialization_options.clone())
            .unwrap_or_default();
        println!("settings: {:#?}", settings);
        Ok(Some(settings))
    }
}

zed::register_extension!(ClarityExtension);
