
# InstallLiberator V1

InstallLiberator is a simple and powerful tool designed to automate the installation and uninstallation of programs on Windows systems. With an easy setup and quick execution, it saves you time and eliminates the hassle of manual installations.

---

## 📋 Requirements

- An active Internet connection is required to download software.
- Verify the availability of desired programs on [Chocolatey](https://community.chocolatey.org/packages) before adding them to your installation list.
- Ensure your system has the necessary administrative rights to execute installation/uninstallation scripts.

---

## 🚀 Features

- Automatic installation of software listed in a configuration file.
- Real-time installation progress displayed in the console.
- Detailed logs available for every operation in the **Logs** folder.
- Quick and easy uninstallation of installed programs.

---

## 🛠 Program Installation

1. **Set up the program list**:
   - Open the `Programs-List` file located in the main folder using a text editor like Notepad.
   - Add the exact names of the programs you want to install, one program per line.
   - Use the names as they appear on [Chocolatey](https://community.chocolatey.org/packages) (do not include `choco install`).

   Example:
   ```plaintext
   googlechrome
   vscode
   git
   ```

2. **Start the installation**:
   - Double-click the `Setup install` file in the main folder.
   - Allow execution if prompted.
   - Follow the progress displayed in the console.

3. **Check the installation logs**:
   - Review the log files in the `Scripts/Logs` folder for details about the operations performed.

4. **Complete the installation**:
   - Once the installation is complete, a confirmation message will appear.
   - Restart your system to ensure all changes take effect.

---

## 🧹 Program Uninstallation

1. **Start the uninstallation**:
   - Double-click the `Setup uninstall` file located in the main folder.
   - Allow execution if prompted.
   - Some software may require manual confirmation during the process.

2. **Monitor the progress**:
   - The script will automatically uninstall the programs previously installed.
   - Follow the steps in the console.

3. **Complete the uninstallation**:
   - A confirmation message will appear once the uninstallation is finished.
   - Restart your system to remove any remaining files or traces of the uninstalled programs.

---

## ⚠️ Important Notes

- Some programs may not be available on Chocolatey and will require manual installation.
- Installation speed may vary based on your Internet connection, system performance, and the software provider's servers.
- Check for updates to the tool and your installed programs regularly.

---

## 🗂 Logs History

Log files containing details of every operation are stored in the `Scripts/Logs` folder. Use these logs to:
- Verify the status of installations or uninstallations.
- Troubleshoot any issues encountered during execution.

---


**Install faster. Uninstall effortlessly.** With InstallLiberator, save time and simplify your software management! 🎉
