namespace api.FMPConfigManager;

class KeyManager
{
    public string GetKey()
    {
        string[] keys = File.ReadAllLines("/home/flare/Desktop/Stoc/api/api_keys.txt");
        Random random = new Random();
        int index = random.Next(0, keys.Length);
        return keys[index];
    }
}