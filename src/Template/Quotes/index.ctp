<?php
/**
  * @var \App\View\AppView $this
  * @var \App\Model\Entity\Quote[]|\Cake\Collection\CollectionInterface $quotes
  */
?>
<nav class="large-3 medium-4 columns" id="actions-sidebar">
    <ul class="side-nav">
        <li class="heading"><?= __('Actions') ?></li>
        <li><?= $this->Html->link(__('New Quote'), ['action' => 'add']) ?></li>
        <li><?= $this->Html->link(__('List Authors'), ['controller' => 'Authors', 'action' => 'index']) ?></li>
        <li><?= $this->Html->link(__('New Author'), ['controller' => 'Authors', 'action' => 'add']) ?></li>
        <li><?= $this->Html->link(__('List Tags'), ['controller' => 'Tags', 'action' => 'index']) ?></li>
        <li><?= $this->Html->link(__('New Tag'), ['controller' => 'Tags', 'action' => 'add']) ?></li>
    </ul>
</nav>
<div class="quotes index large-9 medium-8 columns content">
    <h3><?= __('Quotes') ?></h3>
    <?php foreach ($quotes as $quote): ?>
        <div class="row quote">
            <div class="author">
                (<?= $quote->has('author') ? $this->Html->link($quote->author->name, ['controller' => 'Authors', 'action' => 'view', $quote->author->id]) : '' ?>)
            </div>
            <q><?= h($quote->quote) ?></q>
            <div class="row">
                <div class="tags columns large-8">
                    <?php
                    foreach ($quote->tags as $tag) {
                        print '<span>' . $tag->name . '</span>';
                    }
                    ?>
                </div>
                <time class="columns large-4"><?= h($quote->created) ?></time>
            </div>
        </div>
    <?php endforeach; ?>
    <div class="paginator">
        <ul class="pagination">
            <?= $this->Paginator->first('<< ' . __('first')) ?>
            <?= $this->Paginator->prev('< ' . __('previous')) ?>
            <?= $this->Paginator->numbers() ?>
            <?= $this->Paginator->next(__('next') . ' >') ?>
            <?= $this->Paginator->last(__('last') . ' >>') ?>
        </ul>
        <p><?= $this->Paginator->counter(['format' => __('Page {{page}} of {{pages}}, showing {{current}} record(s) out of {{count}} total')]) ?></p>
    </div>
</div>
