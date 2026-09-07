package naay.dev.medals;

import naay.dev.medals.cmd.MedalCommand;
import naay.dev.medals.listener.MedalListener;
import naay.dev.medals.manager.MedalManager;
import naay.dev.core.Main;
import org.bukkit.plugin.java.JavaPlugin;

public class Main extends JavaPlugin {

    private static Main instance;

    @Override
    public void onEnable() {
        instance = this;
        saveDefaultConfig();
        
        MedalManager.setup();
        MedalCommand.register();
        MedalListener.setup();

        getLogger().info("NaayMedals ativado!");
    }

    @Override
    public void onDisable() {
        getLogger().info("NaayMedals desativado.");
    }

    public static Main getInstance() {
        return instance;
    }
}