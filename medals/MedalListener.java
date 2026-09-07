package naay.dev.medals.listener;

import naay.dev.medals.manager.MedalManager;
import naay.dev.core.Main;
import naay.dev.core.player.Profile;
import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.entity.PlayerDeathEvent;
import org.bukkit.event.player.PlayerJoinEvent;

public class MedalListener implements Listener {

    public static void setup() {
        Main.instance.getServer().getPluginManager().registerEvents(new MedalListener(), Main.instance);
    }

    @EventHandler
    public void onJoin(PlayerJoinEvent e) {
        Player p = e.getPlayer();
        checkMedalsUnlock(p);
    }

    @EventHandler
    public void onDeath(PlayerDeathEvent e) {
        if (e.getEntity() instanceof Player) {
            Player victim = (Player) e.getEntity();
            Profile profile = Profile.getProfile(victim.getName());
            if (profile != null) {
                int deaths = profile.getDeaths() + 1;
                profile.setDeaths(deaths);
                
                if (deaths == 1) {
                    MedalManager.addMedal(victim, "bronze");
                    victim.sendMessage("§aVocê ganhou a medalha §cBronze§a!");
                } else if (deaths == 10) {
                    MedalManager.addMedal(victim, "silver");
                    victim.sendMessage("§aVocê ganhou a medalha §fPrata§a!");
                }
            }
        }
    }

    private void checkMedalsUnlock(Player p) {
        Profile profile = Profile.getProfile(p.getName());
        if (profile == null) return;
        
        int wins = profile.getWins();
        if (wins >= 1) {
            MedalManager.addMedal(p, "gold");
        }
    }
}