import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Le widget principal qui configure l'application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Définit un titre global et retire la bannière de débogage
      title: 'Ma To-Do List',
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),
    );
  }
}

// Le widget d'écran principal, qui est "Stateful" car son contenu va changer
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

// La classe qui gère l'état (les données) de notre écran
class _TodoListScreenState extends State<TodoListScreen> {
  // La liste qui contiendra toutes nos tâches. C'est notre "état".
  final List<String> _tasks = [];

  // Un "contrôleur" pour lire le texte que l'utilisateur tape dans le champ.
  final TextEditingController _controller = TextEditingController();

  // La fonction pour ajouter une tâche
  void _addTask() {
    // On vérifie que le champ n'est pas vide
    if (_controller.text.isNotEmpty) {
      // setState() est crucial : il dit à Flutter que l'état a changé
      // et qu'il faut redessiner l'interface.
      setState(() {
        _tasks.add(_controller.text); // Ajoute la nouvelle tâche à la liste
        _controller.clear();          // Vide le champ de texte
      });
    }
  }

  // La fonction pour supprimer une tâche à une position (index) donnée
  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index); // Retire l'élément de la liste
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Liste de Tâches'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // La rangée contenant le champ de texte et le bouton "+"
            Row(
              children: [
                // Expanded permet au TextField de prendre toute la place disponible
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Nouvelle tâche',
                    ),
                    // Permet d'ajouter la tâche en appuyant sur "Entrée"
                    onSubmitted: (value) => _addTask(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, size: 30, color: Colors.blueAccent),
                  onPressed: _addTask, // Le bouton appelle notre fonction _addTask
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Expanded permet à la liste de prendre tout l'espace vertical restant
            Expanded(
              // ListView.builder est très efficace pour afficher de longues listes.
              // Il ne construit que les éléments visibles à l'écran.
              child: ListView.builder(
                itemCount: _tasks.length, // Le nombre d'éléments à afficher
                itemBuilder: (context, index) {
                  // Pour chaque élément de la liste, on crée une "carte"
                  return Card(
                    child: ListTile(
                      title: Text(_tasks[index]),
                      // On ajoute une icône "poubelle" à la fin de la ligne
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeTask(index), // Appelle la suppression
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}