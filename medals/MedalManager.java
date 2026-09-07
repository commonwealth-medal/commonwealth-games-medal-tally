package naay.dev.medals.manager;

import naay.dev.core.Main;
import naay.dev.core.database.Database;
import org.bukkit.entity.Player;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MedalManager {

    private static final Map<String, Medal> medals = new HashMap<>();

    public static void setup() {
        medals.clear();
        
        medals.put("gold", new Medal("gold", "§6Ouro", "§e★", " Medalha de Ouro", 100));
        medals.put("silver", new Medal("silver", "§fPrata", "§7★★", " Medalha de Prata", 50));
        medals.put("bronze", new Medal("bronze", "§cBronze", "§c★★", " Medalha de Bronze", 25));

        if (Main.instance.getConfig().contains("medals")) {
            for (String key : Main.instance.getConfig().getConfigurationSection("medals").getKeys(false)) {
                String name = Main.instance.getConfig().getString("medals." + key + ".name");
                String icon = Main.instance.getConfig().getString("medals." + key + ".icon");
                String description = Main.instance.getConfig().getString("medals." + key + ".description");
                int xp = Main.instance.getConfig().getInt("medals." + key + ".xp", 0);
                
                medals.put(key, new Medal(key, name, icon, description, xp));
            }
        }
    }

    public static Medal getMedal(String id) {
        return medals.get(id);
    }

    public static List<Medal> getPlayerMedals(Player p) {
        List<Medal> playerMedals = new ArrayList<>();
        try {
            PreparedStatement ps = Database.prepare("SELECT medals FROM player_medals WHERE player = ?");
            ps.setString(1, p.getName());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String[] medalIds = rs.getString("medals").split(",");
                for (String id : medalIds) {
                    Medal medal = medals.get(id);
                    if (medal != null) {
                        playerMedals.add(medal);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return playerMedals;
    }

    public static void addMedal(Player p, String medalId) {
        try {
            String current = getPlayerMedals(p).toString();
            String newMedals = current.isEmpty() ? medalId : current + "," + medalId;
            
            PreparedStatement ps = Database.prepare("INSERT INTO player_medals (player, medals) VALUES (?, ?) ON DUPLICATE KEY UPDATE medals = ?");
            ps.setString(1, p.getName());
            ps.setString(2, newMedals);
            ps.setString(3, newMedals);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static class Medal {
        private final String id;
        private final String name;
        private final String icon;
        private final String description;
        private final int xp;

        public Medal(String id, String name, String icon, String description, int xp) {
            this.id = id;
            this.name = name;
            this.icon = icon;
            this.description = description;
            this.xp = xp;
        }

        public String getId() { return id; }
        public String getName() { return name; }
        public String getIcon() { return icon; }
        public String getDescription() { return description; }
        public int getXp() { return xp; }
    }
}