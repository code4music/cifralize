# 🎸 Cifralize

**Cifralize** é uma plataforma colaborativa para músicos, bandas e ministérios organizarem
**cifras**, **playlists** e **gravações de ensaio ou guia**, com foco em simplicidade, produtividade e acessibilidade.

---

## 🚀 Funcionalidades

* 🎼 **Gerenciamento de Cifras**

  * Criação e edição de músicas com cifras personalizadas.
  * Suporte à importação automática via link do [Cifra Club](https://www.cifraclub.com.br).
  * Agrupamento por artista ou playlist.

* 📦 **Playlists e Repertórios**

  * Crie listas personalizadas para ensaios, eventos ou apresentações.
  * Organize músicas por ordem e contexto.

* 🎤 **Gravação de Guias ou Ensaios**

  * Envie gravações de guia diretamente nas músicas.
  * Facilite a preparação de músicos com áudios de referência.

* 👥 **Colaboração**

  * Compartilhe repertórios com sua equipe.
  * Ideal para bandas, grupos de louvor ou estudo musical.

---

## 💠 Como executar o projeto

### 📦 Build da imagem Docker:

```bash
make build
```

### 📓 Criação do banco de dados:

```bash
make db
```

### ▶️ Subir a aplicação:

```bash
make up
```

Acesse via navegador:
[http://localhost:3000](http://localhost:3000)

---

## 🧱 Requisitos

* Docker + Docker Compose
* Make

---

## 🧑‍💻 Contribuição

Sinta-se à vontade para abrir uma issue ou pull request. Toda ajuda é bem-vinda!
Veja a aba de [Issues](https://github.com/code4music/cifralize/issues) para sugestões de melhorias ou bugs.

---

## 📄 Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.

---

Feito com ❤️ para músicos que precisam de organização e praticidade.

Atualizar posição das playlists:

```
Playlist.find_each do |playlist|
  playlist.playlist_songs.order(:created_at).each.with_index(1) do |ps, index|
    ps.update_column(:position, index)
  end
end
```
