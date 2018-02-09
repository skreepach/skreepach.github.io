<?php
session_start();
require 'vendor/autoload.php';
$app = new \atk4\ui\App("Myasnoi");
$layout = $app->initLayout('Centered');
$age = 13;


$db = new
\atk4\data\Persistence_SQL('mysql:dbname=fdb;host=localhost','root','');

class Friends extends \atk4\data\Model {
  public $table = 'friends';
  function init() {
    parent::init();
    $this->addField('nickname');
    $this->addField('password',['type'=>'password']);
    $this->addField('birthday',['type'=>'date']);
    $this->addField('age');
  }
}

$form = $app->layout->add('Form');
$form->setModel(new Friends($db));
$form->onSubmit(function($form){
  $_SESSION['nickname'] = $form->model['nickname'];

  if($form->model['age']>13){
    $form->model->save();
    return new \atk4\ui\jsExpression('document.location = "success.php"');
  }else{
    //return $form->error('age','Idi yrochki zybri');
    return new \atk4\ui\jsExpression('document.location = "error.php"');
  }
});
$grid=$app->layout->add('Grid');
$grid->setModel(new Friends($db));

$crud=$app->layout->add('CRUD');
$crud->setModel(new Friends($db));

unset($_SESSION['nickname']);
