# Farma Lembrete

App Flutter com Provider para controle diário de medicamentos.

## Como criar o projeto
1. `flutter create farma_lembrete`
2. `cd farma_lembrete && flutter pub add provider`
3. Substitua a pasta `lib/` pelos arquivos deste projeto
4. `flutter run`

## Conceitos de Provider usados
- `ChangeNotifier` (MedicamentoProvider) com `notifyListeners()`
- `ChangeNotifierProvider` no `main.dart`
- `Consumer`, `context.watch` e `context.read`
- Estado compartilhado entre Home, Cadastro e Resumo
