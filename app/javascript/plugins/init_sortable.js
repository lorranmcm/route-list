import Sortable from 'sortablejs';

const initSortable = () => {
  const list = document.querySelector('#tasks');
  Sortable.create(list);
};

export { initSortable };
