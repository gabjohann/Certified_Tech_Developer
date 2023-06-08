/* Faça os seguintes relatórios */

USE DHtube;

/* 1. Listar todos os países que contêm a letra A, ordenados alfabeticamente. */

SELECT 
    nome
FROM
    pais
WHERE
    nome LIKE '%a%'
ORDER BY nome;


/* 2. Gere uma lista de usuários, com detalhes de todos os seus dados, o avatar que possuem e qual país pertencem. */

SELECT 
    usuario.nome AS nome_usuario,
    usuario.email,
    usuario.senha,
    usuario.dataNascimento,
    usuario.codigoPostal,
    avatar.nome AS nome_avatar,
    pais.nome AS nome_pais
FROM
    usuario INNER JOIN
    pais ON pais_idPais = idPais
        INNER JOIN
    avatar ON AVAtar_idAvatar = idAvatar;


/* 3. Faça uma lista com os usuários que possuem playlists, mostrando a quantidade que possuem. */

SELECT 
    usuario.nome AS nome_usuario,
    COUNT(DISTINCT (playlist.nome)) AS qtd_playlists
FROM
    usuario
        INNER JOIN
    playlist ON usuario.idUsuario = usuario_idUsuario
GROUP BY nome_usuario;


/* 4. Mostrar todos os canais criados entre 01/04/2021 e 01/06/2021. */

SELECT 
    nome
FROM
    canal
WHERE
    dataCriacao BETWEEN '2021/04/01' AND '2021/06/01';


/* 5. Mostre os 5 vídeos com a menor duração, listando o título do vídeo, a  tag ou tags que possuem, o nome de usuário e o país ao qual correspondem. */

SELECT 
    video.titulo AS titulo_video,
    video.duracao AS duracao_video,
    usuario.nome AS nome_usuario,
    pais.nome AS pais_usuario,
    hashtag.nome AS hashtag
FROM
    video AS video
        INNER JOIN
    usuario AS usuario ON usuario.idUsuario = video.usuario_idUsuario
        INNER JOIN
    pais AS pais ON pais.idPais = usuario.Pais_idPais
        INNER JOIN
    video_hashtag AS video_hashtag ON video_hashtag.video_idVideo = video.idVideo
        INNER JOIN
    hashtag AS hashtag ON hashtag.idHashtag = video_hashtag.hashtag_idHashtag
ORDER BY video.duracao
LIMIT 5;


/* 6. Liste todas as playlists que possuem menos de 3 vídeos, mostrando o nome de usuário e avatar que possuem. */

SELECT 
    video.titulo AS titulo_video,
    COUNT(DISTINCT (playlist.nome)) qtd_video
FROM
    video AS video
        INNER JOIN
    playlist_video AS playlistVideo ON video.idVideo = playlistVideo.video_idVideo
        INNER JOIN
    playlist AS playlist ON playlistVideo.Playlist_idPlaylist = playlist.idPlaylist
GROUP BY video.titulo
HAVING qtd_video <= 3
ORDER BY qtd_video;


/* 7. Insira um novo avatar e atribua-o a um usuário */

INSERT INTO avatar (nome) VALUES ('Lucas');

UPDATE usuario 
SET 
    Avatar_idAvatar = 10
WHERE
    idUsuario = 19;


/* 8. Gere um relatório de estilo de classificação de avatares usados ​​por país. */

SELECT 
    usuario.nome, avatar.nome, pais.nome
FROM
    usuario
        INNER JOIN
    pais ON pais.idPais = usuario.Pais_idPais
        INNER JOIN
    avatar ON avatar.idAvatar = usuario.Avatar_idAvatar
ORDER BY pais.nome;


/* 9. Insira um usuário com os seguintes dados:
        Nome: Roberto Rodriguez
        E-mail: rrodriguez@DHtube.com
        Password: rr1254
        Data de nascimento: 01 de novembro de 1975
        Código postal: 1429
        País: Argentino
        Avatar: carita feliz 
*/

INSERT INTO avatar (nome, urlImagem) VALUES ('Roberto Rodriguez', 'https://encurtador.com.br/klyL6'); # ID=87
INSERT INTO pais (nome) VALUES ('Argentina');
INSERT INTO usuario (nome, email, senha, dataNascimento, codigoPostal, Pais_idPais, Avatar_idAvatar) VALUES ('Roberto Rodriguez', 'rrodriguez@DHtube.com', 'rr1254', '1975-11-01', '1429', 9, 87);


/* 10. Gere um relatório de todos os vídeos e suas hashtags, mas apenas aqueles cujos nomes de hashtags 
contêm menos de 10 caracteres, classificados em ordem crescente pelo número de caracteres na hashtag.
*/

SELECT 
    video.descricao AS descricao_video, hashtag.nome AS hashtag
FROM
    video
        INNER JOIN
    video_hashtag AS video_hashtag ON video_hashtag.video_idVideo = video.idVideo
        INNER JOIN
    hashtag ON hashtag.idHashtag = video_hashtag.hashtag_idHashtag
WHERE
    LENGTH(hashtag.nome) < 10
ORDER BY hashtag;