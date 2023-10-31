CREATE DATABASE LabCafeteria_G4;

USE master 
GO
CREATE LOGIN usrcafeteria WITH PASSWORD=N'6543210',
     DEFAULT_DATABASE=LabCafeteria_G4,
     CHECK_EXPIRATION=OFF,
     CHECK_POLICY=ON
GO 
USE LabCafeteria_G4
GO 
CREATE USER usrcafeteria FOR LOGIN usrcafeteria
GO 
ALTER ROLE db_owmer ADD MEMBER usrcafeteria
GO

DROP TABLE Producto;
DROP TABLE Categoria;
DROP TABLE Usuario;
DROP TABLE Empleado;

CREATE TABLE Empleado(
  id_Empleado INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  nombre VARCHAR(20) NOT NULL,
  apellidoPaterno VARCHAR(20) NOT NULL,
  apellidoMaterno VARCHAR(20) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  cargo VARCHAR(20) NOT NULL,
  salario FLOAT NOT NULL,
);

CREATE TABLE Usuario(
  id_Usuario INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  id_Empleado INT NOT NULL,
  usuario VARCHAR(30) NOT NULL,
  contraseña VARCHAR(30) NOT NULL,
  FOREIGN KEY (id_Empleado) REFERENCES Empleado(id_Empleado)
);

CREATE TABLE Categoria(
  id_Categoria INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  nombre VARCHAR(30) NOT NULL
);

CREATE TABLE Producto(
  id_Producto INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  id_Categoria INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(500) NOT NULL,
  precio FLOAT NOT NULL,
  FOREIGN KEY (id_Categoria) REFERENCES Categoria(id_Categoria)
);

ALTER TABLE Empleado ADD usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Empleado ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Empleado ADD estado SMALLINT NOT NULL DEFAULT 1;

ALTER TABLE Usuario ADD usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Usuario ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Usuario ADD estado SMALLINT NOT NULL DEFAULT 1;

ALTER TABLE Categoria ADD usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Categoria ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Categoria ADD estado SMALLINT NOT NULL DEFAULT 1;

ALTER TABLE Producto ADD usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Producto ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Producto ADD estado SMALLINT NOT NULL DEFAULT 1;



--Procedimientos Almacenados

CREATE PROC paEmpleadoListar @parametro VARCHAR(50)
AS
  SELECT id_Empleado,nombre,apellidoPaterno,apellidoMaterno,telefono,direccion,cargo,salario
  FROM Empleado
  WHERE estado<>-1 AND nombre LIKE '%'+REPLACE(@parametro,' ','%')+'%';


CREATE PROC paProductoListar @parametro VARCHAR(50)
AS
  SELECT id_Producto,id_Categoria,nombre,descripcion,precio
  FROM Producto
  WHERE estado<>-1 AND nombre LIKE '%'+REPLACE(@parametro,' ','%')+'%';
