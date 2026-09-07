package naay.dev.medals.cmd;

import naay.dev.medals.manager.MedalManager;
import naay.dev.core.Main;
import org.bukkit.command.Command;
import org.bukkit.command.CommandExecutor;
import org.bukkit.command.CommandSender;
import org.bukkit.entity.Player;

import java.util.List;

public class MedalCommand implements CommandExecutor {

    public static void register() {
        Main.instance.getCommand("medal").setExecutor(new MedalCommand());
    }

    @Override
    public boolean onCommand(CommandSender sender, Command cmd, String label, String[] args) {
        if (!(sender instanceof Player)) return true;
        Player p = (Player) sender;

        if (args.length == 0) {
            showMedals(p);
        } else if (args[0].equalsIgnoreCase("list")) {
            showAllMedals(p);
        }
        return true;
    }

    private void showMedals(Player p) {
        List<MedalManager.Medal> playerMedals = MedalManager.getPlayerMedals(p);
        
        p.sendMessage("§6§lSUAS MEDALHAS");
        if (playerMedals.isEmpty()) {
            p.sendMessage("§cVocê não possui medalhas.");
        } else {
            for (MedalManager.Medal medal : playerMedals) {
                p.sendMessage(medal.getIcon() + " " + medal.getName());
            }
        }
    }

    private void showAllMedals(Player p) {
        p.sendMessage("§6§lMEDALHAS DISPONÍVEIS");
        for (MedalManager.Medal medal : MedalManager.medals.values()) {
            p.sendMessage(medal.getIcon() + " " + medal.getName() + " §7- §e" + medal.getXp() + " XP");
        }
    }
}