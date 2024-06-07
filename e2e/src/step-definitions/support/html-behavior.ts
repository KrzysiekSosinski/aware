import { Page } from 'playwright';
import { ElementLocator } from '../../env/globals';

export const clickElement = async (
  page: Page,
  elementIdentifier: ElementLocator
): Promise<void> => {
  await page.click(elementIdentifier);
};

export const inputElementValue = async (
  page: Page,
  elementIdentifier: ElementLocator,
  input: string
): Promise<void> => {

  await page.focus(elementIdentifier)
  await page.fill(elementIdentifier, input)
}

export const selectElementValue = async (
  page: Page,
  optionElementPath: ElementLocator,
  dropdownElementPath: ElementLocator,
  option: string
): Promise<void> => {

  const optionSelector = optionElementPath.replace('{{value}}', option)

  await page.focus(dropdownElementPath)
  await page.click(dropdownElementPath);
  await page.waitForSelector(optionSelector);
  await page.click(optionSelector);
}

export const checkElement = async (
  page: Page,
  elementIdentifier: ElementLocator
): Promise<void> => {
  await page.check(elementIdentifier)
}

export const uncheckElement = async (
  page: Page,
  elementIdentifier: ElementLocator
): Promise<void> => {
  await page.uncheck(elementIdentifier)
}

export const elementChecked = async (
  page: Page,
  elementIdentifier: ElementLocator,
): Promise<boolean | null> => {
  const checked = await page.isChecked(elementIdentifier)
  return checked
}

export const hoverOverElement = async (
  page: Page,
  elementIdentifier: ElementLocator
): Promise<void> => {
  await page.hover(elementIdentifier);
};

export const getAttributeText = async(
  page: Page,
  elementIdentifier: ElementLocator,
  attribute: string,
): Promise<string | null> => {
  return page.locator(elementIdentifier).getAttribute(attribute)
}
